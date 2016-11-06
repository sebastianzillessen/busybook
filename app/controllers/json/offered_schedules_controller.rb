module Json
  class OfferedSchedulesController < JsonController
    before_action :set_offered_schedule, only: [:show, :edit, :update, :destroy]

    def update
      if (params[:approve])
        @offered_schedule.accept!
      elsif (params[:reject])
        @offered_schedule.reject!
      end


    end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_offered_schedule
      @offered_schedule = Schedules::OfferedSchedule.find(params[:id])
    end


  end
end