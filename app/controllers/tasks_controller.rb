class TasksController < ApplicationController

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

  private

  def permitted_params
    params.require('task').permit(:title, :description)
  end

  def error_message
    @task.errors.full_messages.join('; ')
  end

end
