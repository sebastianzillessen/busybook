module Json
  class CalendarsController < JsonController
    before_action :set_calendar, only: [:show, :edit, :update, :destroy]

    def show
      @start = Date.parse(params[:start])
      @end = Date.parse(params[:end])
      render json: @calendar.schedules.where("date_start >= ? and date_end <= ?", @start, @end)
    end

    private
    def set_calendar
      @calendar = @user.calendars.find(params[:id])
    end
  end
end