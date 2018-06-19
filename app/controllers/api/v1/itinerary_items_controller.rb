class Api::V1::ItineraryItemsController < ApplicationController
  before_action :set_itinerary
  before_action :set_itinerary_item, only: [:show, :update, :destroy]
  

  def_param_group :itinerary_item do
    param :itinerary_id, Fixnum, :desc => "Itinerary ID"
    param :index, Fixnum, :desc => "Index"
    param :task_id, Fixnum, :desc => "Task ID"
    param :done, [true, false, "true", "false"], :desc => "Done"
  end

  param_group :itinerary_item
  api :GET, "itineraries/:itinerary_id/itinerary_items", "Show all itinerary items"
  def index
    @itinerary_items = @itinerary.itinerary_items.order('index')

    render json: @itinerary_items
  end

  param_group :itinerary_item
  api :GET, "itineraries/:itinerary_id/itinerary_items/:id", "Show a itinerary item details"
  def show
    render json: @itinerary_item
  end

  param_group :itinerary_item
  api :POST, "itineraries/:itinerary_id/itinerary_items", "Create a itinerary item"
  def create
    @itinerary_item = ItineraryItem.new(itinerary_item_params)

    if @itinerary_item.save
      render json: @itinerary_item, status: :created
    else
      render json: @itinerary_item.errors, status: :unprocessable_entity
    end
  end

  param_group :itinerary_item
  api :PUT, "itineraries/:itinerary_id/itinerary_items/:id", "Edit a itinerary item"
  def update
    if @itinerary_item.update(itinerary_item_params)
      render json: @itinerary_item
    else
      render json: @itinerary_item.errors, status: :unprocessable_entity
    end
  end

  api :DELETE, "itineraries/:itinerary_id/itinerary_items/:id", "Delete a itinerary item"
  def destroy
    @itinerary_item.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_itinerary_item
      @itinerary_item = @itinerary.itinerary_items.find(params[:id])
    end

    def set_itinerary
      @itinerary = Itinerary.find(params[:itinerary_id])
    end

    # Only allow a trusted parameter "white list" through.
    def itinerary_item_params
      params.require(:itinerary_item).permit(:itinerary_id, :index, :done, :task_id)
    end
end
