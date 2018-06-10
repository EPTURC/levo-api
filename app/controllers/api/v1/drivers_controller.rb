class Api::V1::DriversController < ApplicationController
  before_action :set_driver, only: [:show, :update, :destroy]

  # GET /api/v1/drivers
  def index
    @drivers = Driver.all

    render json: @drivers
  end

  # GET /api/v1/drivers/1
  def show
    render json: @driver
  end

  # POST /api/v1/drivers
  def create
    @driver = Driver.new(driver_params)

    if @driver.save
      render json: @driver, status: :created, location: @driver
    else
      render json: @driver.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v1/drivers/1
  def update
    if @driver.update(driver_params)
      render json: @driver
    else
      render json: @driver.errors, status: :unprocessable_entity
    end
  end

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
