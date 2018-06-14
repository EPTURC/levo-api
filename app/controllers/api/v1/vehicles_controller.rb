class Api::V1::VehiclesController < ApplicationController
  before_action :set_vehicle, only: [:show, :update, :destroy]
  
  api :GET, "vehicles", "Show all vehicles"
  def index
    @vehicles = Vehicle.all.includes(:locations)
    
    render json: @vehicles 
  end

  api :GET, "vehicles/:id", "Show a vehicle details"
  def show
    render json: @vehicle
  end

  api :POST, "vehicles", "Create a vehicle"
  def create
    @vehicle = Vehicle.new(vehicle_params)

    if @vehicle.save
      render json: @vehicle, status: :created, location: @vehicle
    else
      render json: @vehicle.errors, status: :unprocessable_entity
    end
  end

  api :PUT, "vehicles/:id", "Edit a vehicle"
  # PATCH/PUT /api/v1/vehicles/1
  def update
    if @vehicle.update(vehicle_params)
      render json: @vehicle
    else
      render json: @vehicle.errors, status: :unprocessable_entity
    end
  end

  api :DELETE, "vehicles/:id", "Delete a vehicle"
  # DELETE /api/v1/vehicles/1
  def destroy
    @vehicle.destroy
  end

  api :GET, "vehicles/search/:company_id", "Find a vehicle by his company_id"
  def search_by_company_id
    @vehicle = Vehicle.find_by('lower(company_id) ILIKE ?', "%" + params[:name].downcase+"%")
    
    if @vehicle
      render json: @vehicle
    else
      render json: { error: "Not found" }, status: :not_found
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_vehicle
      @vehicle = Vehicle.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def vehicle_params
      params.required(:vehicle).permit(:company_id)
    end
end
