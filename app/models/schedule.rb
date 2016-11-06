class Schedule < ActiveRecord::Base
  belongs_to :calendar
  has_one :user, through: :calendar
  belongs_to :offer

  validates :component, presence: true, inclusion: %w(VEVENT VTODO)
  validates :uri, presence: true, uniqueness: true
  validates :ics, presence: true


  before_validation :parse_and_save_ics
  before_validation :ensure_uri


  def self.in_time_range(calendar, range_start, range_end)
    sql = ''
    args = []

    if range_start
      sql += '? <= date_start '
      args << range_start
    end

    if range_end
      if sql != ""
        sql += 'AND '
      end
      sql += 'date_end <= ? '
      args << range_end
    end

    self.where(calendar: Calendar.find_by_uri!(calendar)).where(sql, *args)
  end

  def copy_to(calendar, calendar_object)
    ActiveRecord::Base.transaction do
      dst = Schedule.new(uri: calendar_object)
      dst.calendar = Calendar.find_by_uri!(calendar)
      dst.attributes = self.attributes.except('id', 'uri', 'calendar')

      dst.save!
    end
  end

  def move_to(calendar)
    self.calendar = Calendar.find_by_uri!(calendar)
    self.save!
  end


  def ics
    @ics ||=
        if (self[:ics].present?)
          Icalendar::Calendar.parse(self[:ics]).first
        else
          Icalendar::Calendar.new
        end

  end

  def event
    ics.events.first || ics.event
  end

  def body=(body)
    self[:ics] = body
    @ics = nil
    parse_and_save_ics
  end


  def date_start=(dstart)
    event.dtstart = dstart
    self[:date_start]= dstart
  end

  def date_end=(dend)
    event.dtend = dend
    self[:date_end]= dend
  end

  def summary=(sum)
    event.summary = sum
    self[:summary] = sum
  end


  def to_ical
    ics.to_ical
  end

  private
  def parse_and_save_ics
    # accept a calendar event or a ToDo item
    self.component = event.ical_name
    self.date_start = event.dtstart
    self.date_end = event.dtend
    self.summary = event.summary
    self[:ics] = ics.to_ical
  end

  def ensure_uri
    self.uri = SecureRandom.uuid unless self.uri.present?
  end

end
