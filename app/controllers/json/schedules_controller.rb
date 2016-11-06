module Json
  class SchedulesController < JsonController

    def index
      render json: @user.schedules
    end
  end
end