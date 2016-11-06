class SchedulesController < ApplicationController
  before_action :set_schedule, only: [:show, :edit, :update, :destroy]

  # GET /schedules
  def index
    @schedules = Schedule.all
  end

  # GET /schedules/1
  def show
  end

  # GET /schedules/new
  def new
    @schedule = Schedule.new
  end

  # GET /schedules/1/edit
  def edit
  end

  # POST /schedules
  def create
    @schedule = Schedule.new(schedule_params)

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
      @schedule = Schedule.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def schedule_params
      params.fetch(:schedule, {})
    end
end
