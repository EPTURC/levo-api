class Api::V1::ItineraryItemsController < ApplicationController
  before_action :set_itinerary_item, only: [:show, :update, :destroy]

  # GET /itinerary_items
  def index
    @itinerary_items = ItineraryItem.all

    render json: @itinerary_items
  end

  # GET /itinerary_items/1
  def show
    render json: @itinerary_item
  end

  # POST /itinerary_items
  def create
    @itinerary_item = ItineraryItem.new(itinerary_item_params)

    if @itinerary_item.save
      render json: @itinerary_item, status: :created
    else
      render json: @itinerary_item.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /itinerary_items/1
  def update
    if @itinerary_item.update(itinerary_item_params)
      render json: @itinerary_item
    else
      render json: @itinerary_item.errors, status: :unprocessable_entity
    end
  end

  # DELETE /itinerary_items/1
  def destroy
    @itinerary_item.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_itinerary_item
      @itinerary_item = ItineraryItem.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def itinerary_item_params
      params.require(:itinerary_item).permit(:itinerary_id, :index, :done, :task_id)
    end
end
