class ApplicationController < ActionController::API
  require 'json_web_token'

  protected
  def authenticate_user!
    if !retrieve_payload || !JsonWebToken.valid_payload(retrieve_payload.first)
      return invalid_token
    end

    load_current_user!
    invalid_token unless @current_user
  end

  def invalid_token
    render json: { error: 'Invalid authentication token' }, status: :unauthorized
  end

  private
  def retrieve_payload
    auth_header = request.headers['Authorization']

    token = auth_header.split(' ').last

    JsonWebToken.decode(token)
  rescue
    nil
  end

  def load_current_user!
    @current_user = User.find_by(id: retrieve_payload[0]['user_id'])
  end
end
