class TasksController < ApplicationController

  before_action :get_task, only: [:edit, :show, :update, :destroy]

  def index
    @tasks = Task.all
  end

  def create
    @task = Task.new permitted_params
    @task.project = Project.find params[:project_id]
    if @task.save
      redirect_to @task.project
    else
      redirect_to projects_path, notice: error_message
    end
  end

  def new
    @task = Task.new
  end

  def edit
  end

  def show
  end

  def update
    if @task.update permitted_params
      redirect_to @task.project
    else
      redirect_to projects_path, notice: error_message
    end
  end

  def destroy
    @project = @task.project
    if @task.destroy
      redirect_to @project
    else
      redirect_to projects_path, notice: error_message
    end
  end

  private

  def permitted_params
    params.require('task').permit(:title, :description)
  end

  def error_message
    @task.errors.full_messages.join('; ')
  end

  def get_task
    @task = Task.find params[:id]
  end

end
