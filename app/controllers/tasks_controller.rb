class TasksController < ApplicationController

  before_action :get_task, only: [:edit, :show, :update, :destroy]

  def index
    @tasks = Task.all
  end

  def create
    @task = Task.new permitted_params
    if @task.save
      redirect_to @task
    else
      redirect_to new_task_path, notice: error_message
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
      redirect_to @task
    else
      redirect_to edit_task_path, notice: error_message
    end
  end

  def destroy
    if @task.destroy
      redirect_to tasks_path
    else
      redirect_to @task, notice: error_message
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
