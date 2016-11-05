module Propfind
  extend ActiveSupport::Concern

  def propfind_collections
    respond_xml_request('/A:propfind/A:prop/*') do |props|
      results = handle_props(props) do |prop|
        case prop
          when 'displayname'
            ''
          when 'calendar-home-set', 'principal-collection-set', 'principal-URL'
            redirect_to_correct_url
          when 'getctag'
            get_last_change_timestamp
          when 'current-user-privilege-set'
            get_current_user_privileges
          when 'supported-report-set'
            get_supported_report_set
          when 'supported-calendar-component-set'
            get_supported_calendar_component_set
          when 'resourcetype'
            get_resourcetype
        end
      end

      puts "Results: #{results}"

      responses = [["/calendar/", results]]

      if params[:calendar] == ""
        if request.headers["Depth"] == "1"
          cals = @user.calendars.all
        else
          cals = []
        end
      else
        cals = [@user.calendars.find_by_uri!(params[:calendar])]
      end

      puts "Calendar are: #{cals.size}: #{cals}"
      for cal in cals
        calprops = cal.props
        results = handle_props(props) do |prop|
          if calprops.key?(prop)
            calprops[prop]
          else
            case prop
              when 'getctag'
                s = @user.schedules.where(calendar: cal).order('updated_at').last
                (s) ? s.updated_at.to_i.to_s : ''
              when 'current-user-privilege-set'
                get_current_user_privileges
              when 'supported-report-set'
                get_supported_report_set
              when 'resourcetype'
                get_resource_type_calendar
            end
          end
        end
        responses << ["/calendar/#{cal.uri}/", results]
      end

      responses
    end
  end


  private

  def get_resource_type_calendar
    <<-EOS
                <CALDAV:calendar />
                <A:collection />
    EOS
  end

  def get_resourcetype
    <<-EOS
            <A:collection />
	    <A:principal />
    EOS
  end

  def get_supported_calendar_component_set
    <<-EOS
            <CALDAV:comp name="VTODO" />
            <CALDAV:comp name="VEVENT" />
    EOS
  end

  def get_supported_report_set
    <<-EOS
          <supported-report>
            <report><CALDAV:calendar-multiget /></report>
          </supported-report>
          <supported-report>
            <report><CALDAV:calendar-query /></report>
          </supported-report>
    EOS
  end

  def get_current_user_privileges
    <<-EOS
            <A:privilege>
              <A:all />
            </A:privilege>
    EOS
  end

  def get_last_change_timestamp
    s = @user.schedules.order('updated_at').last
    (s) ? s.updated_at.to_i.to_s : ''
  end

  def redirect_to_correct_url
    '<A:href>/calendar/</A:href>'
  end

  def propfind_objects
    # get a list of calendar objects
    respond_xml_request('/A:propfind/A:prop/*') do |props|
      calendar = @user.calendars.find_by_uri!(params[:calendar])
      responses = []
      @user.schedules.where(calendar_id: calendar).find_each do |sched|
        results = handle_props(props) do |prop|
          case prop
            when 'getcontenttype'
              get_content_type
            when 'getetag'
              getetag(sched)
          end
        end
        responses << [sched.uri, results]
      end

      if responses == []
        results = handle_props(props) {}
        responses << ["/calendar/#{calendar.uri}/", results]
      end

      responses
    end
  end

  def get_content_type
    'text/calendar; component=vevent; charset=utf-8'
  end

  def handle_props(props)
    ps = {}
    for prop in props
      r = yield(prop.name)
      status = (r) ? :ok : :not_found

      unless ps.has_key?(status)
        ps[status] = []
      end

      ps[status] << [prop.namespace.prefix, prop.name, r]
    end

    return ps
  end
end
