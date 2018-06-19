class Api::V1::ItinerariesController < ApplicationController
  before_action :set_itinerary, only: [:show, :update, :destroy]

  api :GET, "itineraries", "Show all itineraries"
  def index
    @itineraries = Itinerary.all

    render json: @itineraries
  end

  api :GET, "itineraries/:id", "Show a itinerary details with his items included, ordered by index"
  def show
    render json: @itinerary.as_json(:include => { items: { only: [:task_id, :index, :done] }})
  end

  api :POST, "itineraries", "Create a itinerary"
  def create
    @itinerary = Itinerary.new(itinerary_params)

    if @itinerary.save
      render json: @itinerary, status: :created
    else
      render json: @itinerary.errors, status: :unprocessable_entity
    end
  end

  api :PUT, "itineraries/:id", "Edit a itinerary"
  def update
    if @itinerary.update(itinerary_params)
      render json: @itinerary
    else
      render json: @itinerary.errors, status: :unprocessable_entity
    end
  end

  api :DELETE, "itinerary/:id", "Delete a itinerary"
  def destroy
    @itinerary.destroy
  end

  api :GET, "itinerary/driver/:driver", "Find and show a active itinerary by driver with his items and vehicle included, ordered by index"
  def show_by_driver
    @driver_itinerary = Itinerary.where("status = 'ativo' AND driver_id = ?", params[:driver]).take
    if @driver_itinerary
      render json: 
        @driver_itinerary.as_json(only: [:id, :status], :include => [
                            { vehicle: { only: [:id, :company_id ]}}, 
                            { items: { only: [:index, :done, :id], 
                              :include => { task: 
                                { only: [:object, :responsible_name, :type, :local ]} } }
                            }])
    else
      render json: '{"error": "not_found"}', status: :not_found
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_itinerary
      @itinerary = Itinerary.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def itinerary_params
      params.require(:itinerary).permit(:vehicle_id, :driver_id)
    end
end
