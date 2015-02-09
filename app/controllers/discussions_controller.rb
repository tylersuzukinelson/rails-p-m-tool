class DiscussionsController < ApplicationController

  before_action :authenticate_user!
  before_action :get_discussion, only: [:edit, :show, :update, :destroy]

  def create
    @discussion = Discussion.new discussion_params
    @discussion.project = Project.find params[:project_id]
    @discussion.user = current_user
    if @discussion.save
      unless Delayed::Job.exists?(["handler LIKE ?", "%method_name: :daily_summary\nargs:\n- #{@discussion.project.id}\n%"])
        PmToolerMailer.delay(run_at: Time.now.midnight + 1.day).daily_summary(@discussion.project.id)
      end
      redirect_to @discussion.project
    else
      redirect_to @discussion.project, notice: error_messages
    end
  end

  def edit
  end

  def show
  end

  def update
    if @discussion.update(discussion_params)
      redirect_to @discussion
    else
      redirect_to projects_path, notice: error_messages
    end
  end

  def destroy
    @project = @discussion.project
    if @discussion.destroy
      redirect_to @project
    else
      redirect_to projects_path, notice: error_messages
    end
  end

  private

  def get_discussion
    @discussion = Discussion.find params[:id]
  end

  def discussion_params
    params.require(:discussion).permit(:title, :body)
  end

  def error_messages
    @discussion.errors.full_messages.join('; ')
  end

end
