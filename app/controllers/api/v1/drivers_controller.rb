class Api::V1::DriversController < ApplicationController
  before_action :set_driver, only: [:show, :update, :destroy]

  def_param_group :driver do
    param :user_id, Fixnum, :desc => "User ID"
  end

  param_group :driver
  api :GET, "drivers", "Show all drivers"
  def index
    @drivers = Driver.all

    render json: @drivers
  end

  param_group :driver
  api :GET, "drivers/:id", "Show a driver details"
  def show
    render json: @driver
  end

  param_group :driver
  api :POST, "drivers", "Create a driver"
  def create
    @driver = Driver.new(driver_params)

    if @driver.save
      render json: @driver, status: :created
    else
      render json: @driver.errors, status: :unprocessable_entity
    end
  end

  param_group :driver
  api :PUT, "drivers/:id", "Edit a driver"
  def update
    if @driver.update(driver_params)
      render json: @driver
    else
      render json: @driver.errors, status: :unprocessable_entity
    end
  end

  api :DELETE, "drivers/:id", "Delete a driver"
  def destroy
    @driver.destroy
  end

  param_group :driver
  api :GET, "drivers/name/:name", "Find a driver by the user name"
  def show_by_name
    @user = User.find_by('lower(name) ILIKE ?', "%" + params[:name].downcase+"%")
    if @user
      @driver = Driver.where('user_id = ?', @user.id).take
      if @driver
        render json: @driver
      else
        render json: { error: "Not found" }, status: :not_found
      end
    else
      render json: { error: "Not found" }, status: :not_found
    end
  end

  param_group :driver
  api :GET, "drivers/available", "Show all drivers who are not active"
  def show_available

    @itineraries = Itinerary.all
    @drivers = Driver.all
    
    @availables = []

    @drivers.each do |driver|
      flag = false
      @itineraries.each do |itinerary|
        if driver.user_id == itinerary.driver_id
          flag = true
        end
      end
      if !flag
        @availables.push(driver)
      end
    end
    render json: @availables
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_driver
      @driver = Driver.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def driver_params
      params.required(:driver).permit(:user_id)
    end
end
