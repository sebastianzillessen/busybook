require 'digest/md5'

class CalendarController < ApplicationController
  include Rawrequest # FIXME: used by DavXml
  include Etag
  include Report
  include Propfind
  include DavXml
  include HttpStatus

  skip_before_action :authenticate, only: [:options]
  before_action :set_src_and_dst, only: [:move, :copy]

  def options
    methods = %w(OPTIONS GET PUT DELETE MKCALENDAR PROPFIND PROPPATCH REPORT COPY MOVE)
    headers['Allow'] = methods.join(', ')
    headers['DAV'] = '1, 2, calendar-access, calendarserver-subscribed'
    head :ok
  end

  def get
    entry = @user.schedules.find_by_uri!(params[:calendar_object])
    render status: :ok, body: entry.ics, content_type: 'text/calendar'
  end

  def put
    uri = params[:calendar_object]
    calendar = params[:calendar]

    # handle If-Match
    sched = @user.schedules.find_by_uri(uri)
    if request.headers.key?("If-Match")
      unless sched
        logger.warn "Precondition_failed: #{sched}"
        return head :precondition_failed
      end

      if getetag(sched) != remove_etag_prefix(request.headers["If-Match"])
        logger.warn "etag mismatch: '#{getetag(sched)}' '#{remove_etag_prefix(request.headers["If-Match"])}', ignoring"
        # return head :precondition_failed
      end
    end

    sched = @user.schedules.new(uri: uri) unless sched
    sched.calendar = @user.calendars.find_by_uri!(calendar)
    sched.set_ics(rawrequest)
    if (sched.save)
      head :created
    else
      logger.warn "Could not save Schedule Object: #{sched.errors}"
      head :not_acceptable
    end
  end

  def delete
    cal = @user.calendars.find_by_uri!(params[:calendar])
    if params[:calendar_object] == ""
      cal.destroy
    else
      sched = @user.schedules.find_by_uri!(params[:calendar_object])
      sched.destroy
    end

    head :no_content
  end

  def copy
    @src.copy_to(@dst[:calendar], @dst[:calendar_object])
    head :no_content
  end

  def move
    @src.move_to(@dst[:calendar])
    head :created
  end

  def mkcalendar
    xml = Nokogiri::XML(rawrequest)

    props = {}
    for prop in xml.xpath('/B:mkcalendar/A:set/A:prop/*',
                          A: 'DAV:', B: 'urn:ietf:params:xml:ns:caldav')
      props[prop.name] = replace_xml_nsprefix(xml, prop.children.to_s)
    end

    @user.calendars.create(props: props, uri: params[:calendar])
    head :created
  end

  def report
    xml = Nokogiri::XML(rawrequest)
    type = xml.children[0].name

    logger.info "REPORT type: #{type}"
    res = case type
            when 'calendar-multiget'
              report_multiget(xml)
            when 'calendar-query'
              report_query(xml)
            else
              return head :not_implemented
          end

    render xml: res, status: :multi_status
  end

  def proppatch
    if params[:calendar_object] != "" || params[:calendar] == ""
      logger.warn "PROPPATCH to a calendar object or / is not supported"
      return head :not_implemented
    end

    xml = Nokogiri::XML(rawrequest)
    cal = @user.calendars.find_by_uri!(params[:calendar])
    cal_props = cal.props

    # set properties
    for prop in xml.xpath('/A:propertyupdate/A:set/A:prop/*', A: 'DAV:')
      cal_props[prop.name] = replace_xml_nsprefix(xml, prop.children.to_s)
    end

    # remove properties
    for prop in xml.xpath('/A:propertyupdate/A:remove/A:prop/*', A: 'DAV:')
      cal_props.delete(prop.name)
    end

    cal.props = cal_props
    cal.save!

    res = respond_xml_request('/A:propertyupdate/*/A:prop/*') do |props|
      results = handle_props(props) { '' }
      [["/calendar/#{params[:calendar]}/", results]]
    end

    render xml: res, status: :multi_status
  end

  def propfind
    if params[:calendar] != '' and request.headers["Depth"] == "1"
      logger.info "PROPFIND target: object"
      xml = propfind_objects
    else
      logger.info "PROPFIND target: collections"
      xml = propfind_collections
    end

    puts "xml: #{xml}"
    render xml: xml, status: :multi_status
  end

  private

  def set_src_and_dst
    @src = @user.schedules.find_by_uri!(params[:calendar_object])

    begin
      @dst = Rails.application.routes.recognize_path(request.headers[:destination])
    rescue
      logger.warn "unknown destination url: '#{dst}'"
      return head :bad_request
    end
  end
end
