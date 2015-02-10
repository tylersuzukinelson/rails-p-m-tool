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
      unless Delayed::Job.exists?(["handler LIKE ?", "%method_name: :daily_summary\nargs:\n- #{@project.id}\n%"])
        PmToolerMailer.delay(run_at: Time.now.midnight + 1.day).daily_summary(@project.id)
      end
      @task.reload()
      respond_to do |format|
        format.html { redirect_to @project }
        format.js { render }
      end
    else
      respond_to do |format|
        flash[:alert] = error_message
        format.html { redirect_to @project }
        format.js { render }
      end
    end
  end

  def new
    @task = Task.new
  end

  def edit
    @project = @task.project
    respond_to do |format|
      format.html { render }
      format.js { render }
    end
  end

  def show
    @project = @task.project
  end

  def update
    if !@task.complete && params[:task][:complete]
      @flag_changed_status = true
      set_completed_by = { completed_by: current_user.id }
    elsif @task.complete && params[:task][:complete] == 'false'
      @flag_changed_status = true
      set_completed_by = { completed_by: nil }
    else
      @flag_changed_status = false
      set_completed_by = {}
    end
    @project = @task.project
    if @task.update permitted_params.merge(set_completed_by)
      if @task.completed_by && (@task.user_id != @task.completed_by)
        PmToolerMailer.notify_task_owner(@task).deliver_later
      end
      respond_to do |format|
        format.html { redirect_to @task.project }
        format.js { render }
      end
    else
      flash[:alert] = error_message
      respond_to do |format|
        format.html { redirect_to projects_path }
        format.js { render }
      end
    end
  end

  def destroy
    @project = @task.project
    if @task.destroy
      respond_to do |format|
        format.html { redirect_to @project }
        format.js { render }
      end
    else
      flash[:alert] = error_message
      respond_to do |format|
        format.html { redirect_to projects_path }
        format.js { render }
      end
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
