class SchedulesController < ApplicationController
  before_action :set_schedule, only: [:show, :edit, :update, :destroy]

  # GET /schedules
  def index
    @schedules = @user.schedules.all
  end

  # GET /schedules/1
  def show
  end

  # GET /schedules/new
  def new
    @schedule = @user.schedules.new
  end

  # GET /schedules/1/edit
  def edit
  end

  # POST /schedules
  def create
    @schedule = @user.schedules.new(schedule_params)

    if @schedule.save
      redirect_to @schedule, notice: 'Schedule was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /schedules/1
  def update
    if @schedule.update(schedule_params)
      redirect_to @schedule, notice: 'Schedule was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /schedules/1
  def destroy
    @schedule.destroy
    redirect_to schedules_url, notice: 'Schedule was successfully destroyed.'
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_schedule
    @schedule = @user.schedules.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def schedule_params
    params.require(:schedule).permit(:summary, :date_start, :date_end, :summary, :calendar_id)
  end
end
