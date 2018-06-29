class Api::V1::MessagesController < ApplicationController
  before_action :set_message, only: [:show, :update, :destroy]

  def_param_group :message do
    param :message_text, String, :desc => "Content"
    param :driver_id, Fixnum, :desc => "Receiver driver"
    param :user_id, Fixnum, :desc => "Sender"
  end

  def_param_group :driver_messages do
    param :message_text, String, :desc => "Content"
    param :user_id, Fixnum, :desc => "Sender"
  end

  param_group :message
  api :GET, "messages", "Show all messages"
  def index
    @messages = Message.all

    render json: @messages
  end

  param_group :message
  api :GET, "messages/:id", "Show a message details"
  def show
    render json: @message
  end

  param_group :message
  api :POST, "messages", "Create a message"
  def create
    @message = Message.new(message_params)

    if @message.save
      render json: @message, status: :created
    else
      render json: @message.errors, status: :unprocessable_entity
    end
  end

  param_group :message
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

  param_group :driver_messages
  api :GET, "messages/driver/:driver", "Find and show the messages that belong to the driver"
  def select_by_driver
    @driver_messages = Message.where("driver_id = ?", params[:driver]).take
    if @driver_messages
      render json:
        @driver_messages.as_json(only: [:id, :message], :include => [
          {user: {only: [:id, :name]}}
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
      params.require(:message).permit(:message_text, :user_id, :driver_id)
    end
end
