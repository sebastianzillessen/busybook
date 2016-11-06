class OffersController < ApplicationController
  before_action :set_offer, only: [:show, :edit, :update, :destroy]

  # GET /offers
  def index
    @offers = @user.offers.all
  end

  # GET /offers/1
  def show
  end

  # GET /offers/new
  def new
    @offer = @user.offers.new
  end

  # GET /offers/1/edit
  def edit
  end

  # POST /offers
  def create
    @offer = @user.offers.new(offer_params)

    if @offer.save
      redirect_to @offer, notice: 'Offer was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /offers/1
  def update
    if @offer.update(offer_params)
      redirect_to @offer, notice: 'Offer was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /offers/1
  def destroy
    @offer.destroy
    redirect_to offers_url, notice: 'Offer was successfully destroyed.'
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_offer
    @offer = @user.offers.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def offer_params
    params.require(:offer).permit(:email, :description, offered_schedules_attributes: [:id, :date_start, :date_end, :calendar_id, :_destroy])
  end
end
