module Json
  class OffersController < JsonController
    before_action :set_calendar, only: [:show, :edit, :update, :destroy]

    def show
      @start = Date.parse(params[:start])
      @end = Date.parse(params[:end])
      render json: @offer.offered_schedules.where("date_start >= ? and date_end <= ?", @start, @end), each_serializer: OfferedScheduleSerializer
    end

    private
    def set_calendar
      @offer = @user.offers.find(params[:id])
    end
  end
end