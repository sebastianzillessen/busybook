module Json
  module CalendarsHelper
    def calendar_data_object(cals)
      cals.map do |cal|
        {url: json_calendar_path(cal, format: :json), color: cal.color}
      end.to_json
    end
  end
end
