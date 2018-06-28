class Api::V1::UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy]
  
  def_param_group :user do
    param :name, String, :desc => "User name"
  end

  param_group :user
  api :GET, "users", "Show all users"
  def index
    @users = User.all

    render json: @users
  end

  param_group :user
  api :GET, "users/admins", "Show all admin users"
  def admin_index
    @users = User.where(is_admin: true)

    render json: @users
  end

  param_group :user
  api :GET, "users/:id", "Show a user details"
  def show
    render json: @user
  end

  param_group :user
  api :POST, "users", "Create a user"
  def create
    @user = User.new(user_params)

    if @user.save
      render json: @user, status: :created
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  param_group :user
  api :PUT, "users/:id", "Edit a user"
  def update
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  api :DELETE, "users/:id", "Delete a user"
  def destroy
    @user.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def user_params
      params.require(:user).permit(:name, :is_admin)
    end
end
