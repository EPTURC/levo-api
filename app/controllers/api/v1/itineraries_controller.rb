class Api::V1::ItinerariesController < ApplicationController
  before_action :set_itinerary, only: [:show, :update, :destroy]

  resource_description do
    short 'Itinerários'
    formats ['json']
  end

  def_param_group :itinerary do
    param :vehicle_id, Fixnum, :desc => "Vehicle ID"
    param :driver_id, Fixnum, :desc => "Driver ID"
    param :status, ["ativo", "inativo"], :desc => "Status"
  end

  def_param_group :driver_itinerary do
    param :vehicle_id, Fixnum, :desc => "Vehicle ID"
    param :driver_id, Fixnum, :desc => "Driver ID"
    param :status, String, :desc => "Status"
    param :items, Object, :desc => "Items"
  end

  param_group :itinerary
  api :GET, "itineraries", "Show only active itineraries"
  def index
    @itineraries = Itinerary.where("status='ativo'") 

    render json: @itineraries.as_json(:methods => [:situation])
  end

  param_group :itinerary
  api :GET, "itineraries/all", "Show all itineraries"
  def all_index
    @itineraries = Itinerary.all

    render json: @itineraries.as_json(:include => [
                            { vehicle: { only: [:id, :company_id ], :methods => [:last_location] }} ] , :methods => [:situation])
  end

  param_group :itinerary
  api :GET, "itineraries/:id", "Show a itinerary details with his items included, ordered by index"
  def show
    render json: @itinerary.as_json(:include => { items: { only: [:id, :task_id, :index, :done] }}, :methods => [:situation])
  end

  param_group :itinerary
  api :POST, "itineraries", "Create a itinerary"
  def create
    @itinerary = Itinerary.new(itinerary_params)

    if @itinerary.save
      render json: @itinerary, status: :created
    else
      render json: @itinerary.errors, status: :unprocessable_entity
    end
  end

  param_group :itinerary
  api :PUT, "itineraries/:id", "Edit a itinerary"
  def update
    if @itinerary.update(itinerary_params)
      render json: @itinerary
    else
      render json: @itinerary.errors, status: :unprocessable_entity
    end
  end

  api :DELETE, "itineraries/:id", "Delete a itinerary"
  def destroy
    @itinerary.destroy
  end

  param_group :driver_itinerary
  api :GET, "itineraries/driver/:driver", "Find and show a active itinerary by driver with his items and vehicle included, ordered by index"
  def show_by_driver
    @driver_itinerary = Itinerary.where("status = 'ativo' AND driver_id = ?", params[:driver]).take
    if @driver_itinerary
      render json: 
        @driver_itinerary.as_json(only: [:id, :status], :include => [
                            { vehicle: { only: [:id, :company_id ]}}, 
                            { items: { only: [:index, :done, :id], 
                              :include => { task: 
                                { only: [:object, :responsible_name, :type, :local ]} } }
                            }], :methods => [:situation])
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
      params.require(:itinerary).permit(:vehicle_id, :driver_id, :status)
    end
end
