class TasksController < ApplicationController

  before_action :authenticate_user!
  before_action :get_task, only: [:edit, :show, :update, :destroy]

  def index
    @tasks = Task.all
  end

  def create
    @task = Task.new permitted_params
    @project = Project.find params[:project_id]
    @task.project = @project
    @task.user = current_user
    if @task.save
      redirect_to @project
    else
      redirect_to @project, notice: error_message
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
    if !@task.complete && params[:task][:complete]
      set_completed_by = { completed_by: current_user.id }
    elsif @task.complete && params[:task][:complete] == 'false'
      set_completed_by = { completed_by: nil }
    else
      set_completed_by = {}
    end
    if @task.update permitted_params.merge(set_completed_by)
      if @task.completed_by && (@task.user_id != @task.completed_by)
        PmToolerMailer.notify_task_owner(@task)
      end
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
    params.require('task').permit(:title, :description, :complete, :due_date)
  end

  def error_message
    @task.errors.full_messages.join('; ')
  end

  def get_task
    @task = Task.find params[:id]
  end

end
