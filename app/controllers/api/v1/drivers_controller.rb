class Api::V1::DriversController < ApplicationController
  before_action :set_driver, only: [:show, :update, :destroy]
  api :GET, "drivers", "Show all drivers"
  # GET /api/v1/drivers
  def index
    @drivers = Driver.all

    render json: @drivers
  end
  api :GET, "drivers/:id", "Show a driver details"
  # GET /api/v1/drivers/1
  def show
    render json: @driver
  end
  api :POST, "drivers", "Create a driver"
  # POST /api/v1/drivers
  def create
    @driver = Driver.new(driver_params)

    if @driver.save
      render json: @driver, status: :created
    else
      render json: @driver.errors, status: :unprocessable_entity
    end
  end
  api :PUT, "drivers/:id", "Edit a driver"
  # PATCH/PUT /api/v1/drivers/1
  def update
    if @driver.update(driver_params)
      render json: @driver
    else
      render json: @driver.errors, status: :unprocessable_entity
    end
  end
  api :DELETE, "drivers/:id", "Delete a driver"
  # DELETE /api/v1/drivers/1
  def destroy
    @driver.destroy
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
