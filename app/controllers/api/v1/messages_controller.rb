class Api::V1::MessagesController < ApplicationController
  before_action :set_message, only: [:show, :update, :destroy]

  
  
  api :GET, "messages", "Show all messages"
  def index
    @messages = Message.all

    render json: @messages
  end

  
  api :GET, "messages/:id", "Show a message details"
  def show
    render json: @message
  end

  
  api :POST, "messages", "Create a message"
  def create
    new_messages = []
    errors = []
    drivers = message_params["driver_id"]
    message_text = message_params["message_text"]
    sender = message_params["user_id"]

    drivers.each do |driver|
      @message = Message.new("message_text"=>message_text, "user_id"=>sender, "driver_id"=> driver)
    
      new_messages.push(@message) if @message.save
      errors.push(@message.errors) unless @message.save
    end

    status = :created if new_messages.length == drivers.length
    status = :unprocessable_entity if errors.length == drivers.length
    status = 207 if new_messages.any? && errors.any?

    render json: {"success" => new_messages, "errors" => errors}, status: status 
  end

  
  api :PUT, "messages/:id", "Edit a message"
  def update
    if @message.update(message_params)
      render json: @message
    else
      render json: @message.errors, status: :unprocessable_entity
    end
  end

  api :DELETE, "messages/:id", "Delete a message"
  def destroy
    @message.destroy
  end

  
  api :GET, "messages/driver/:driver", "Find and show the messages that belong to the driver"
  def select_by_driver
    @driver_messages = Message.where("driver_id = ?", params[:driver]).take
    if @driver_messages
      render json:
        @driver_messages.as_json(only: [:id, :message_text, :created_at], :include => [
          {user: {only: [:id, :name]}}, {driver: {only: [:id]}}
        ])
    else
      render json: '{"error": "not_found"}', status: :not_found
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_message
      @message = Message.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def message_params 
      params.require(:message).permit(:message_text, :user_id, :driver_id => [])
    end
end
