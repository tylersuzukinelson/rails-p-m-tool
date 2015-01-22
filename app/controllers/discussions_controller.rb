class DiscussionsController < ApplicationController

  def create
    @discussion = Discussion.new discussion_params
    @discussion.project = Project.find params[:project_id]
    if @discussion.save
      redirect_to @discussion.project
    else
      redirect_to @discussion.project, notice: error_messages
    end
  end

  private

  def discussion_params
    params.require(:discussion).permit(:title, :body)
  end

  def error_messages
    @discussion.errors.full_messages.join('; ')
  end

end
