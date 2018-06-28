class Api::V1::OccurrencesController < ApplicationController
  before_action :set_occurrence, only: [:show, :update, :destroy]

  def_param_group :occurrence do
    param :type, String, :desc => "Type"
    param :location, String, :desc => "Location"
    param :description, String, :desc => "Description"
    param :driver_id, Fixnum, :desc => "Driver reporter"
    param :itinerary_id, Fixnum, :desc => "Related itinerary"
    param :created_at, Date, :desc => "Date"
    param :solved, ["true", "false"], :desc => "Solved"
  end

  param_group :occurrence
  api :GET, "occurrences", "Show all occurrences"
  def index
    @occurrences = Occurrence.all

    render json: @occurrences
  end

  param_group :occurrence
  api :GET, "occurrences/:id", "Show a occurrence details"
  def show
    render json: @occurrence
  end

  param_group :occurrence
  api :POST, "occurrences", "Create a occurrence"
  def create
    @occurrence = Occurrence.new(occurrence_params)
    
    if @occurrence.save
      render json: @occurrence, status: :created
    else
      render json: @occurrence.errors, status: :unprocessable_entity
    end
  end

  param_group :occurrence
  api :PUT, "occurrences/:id", "Edit a occurrence"
  def update
    if @occurrence.update(occurrence_params)
      render json: @occurrence
    else
      render json: @occurrence.errors, status: :unprocessable_entity
    end
  end

  api :DELETE, "occurrences/:id", "Delete a occurrence"
  def destroy
    @occurrence.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_occurrence
      @occurrence = Occurrence.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def occurrence_params
      params.require(:occurrence).permit(:type, :location, :description, :driver_id, :itinerary_id, :solved)
    end

end
