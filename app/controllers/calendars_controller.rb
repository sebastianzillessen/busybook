class CalendarsController < ApplicationController
  before_action :set_calendar, only: [:show, :edit, :update, :destroy]

  # GET /schedules
  def index
    @calendars = @user.calendars
  end

  # GET /schedules/1
  def show
  end


  private
  # Use callbacks to share common setup or constraints between actions.
  def set_schedule
    @schedule = @user.calendars.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def schedule_params
    params.require(:calendars).permit(:name, :color)
  end
end
