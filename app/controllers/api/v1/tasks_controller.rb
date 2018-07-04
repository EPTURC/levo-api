class Api::V1::TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_task, only: [:show, :update, :destroy]

  def_param_group :task do
    param :object, String, :desc => "Object description"
    param :responsible_name, String, :desc => "Responsible Name"
    param :type, ["Entrega", "Coleta"], :desc => "Status"
    param :local, String, :desc => "Local"
  end

  param_group :task
  api :GET, "tasks", "Show all tasks"
  def index
    @tasks = Task.all

    render json: @tasks
  end

  param_group :task
  api :GET, "tasks/:id", "Show a task details"
  def show
    render json: @task
  end

  param_group :task
  api :POST, "tasks", "Create a task"
  def create
    @task = Task.new(task_params)

    if @task.save
      render json: @task, status: :created
    else
      render json: @task.errors, status: :unprocessable_entity
    end
  end

  param_group :task
  api :PUT, "tasks/:id", "Edit a task"
  def update
    if @task.update(task_params)
      render json: @task
    else
      render json: @task.errors, status: :unprocessable_entity
    end
  end

  api :DELETE, "tasks/:id", "Delete a task"
  def destroy
    @task.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def task_params
      params.require(:task).permit(:object, :responsible_name, :type, :local)
    end
end
