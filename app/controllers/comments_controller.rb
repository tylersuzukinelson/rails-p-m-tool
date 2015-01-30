class CommentsController < ApplicationController

  before_action :authenticate_user!
  before_action :get_comment, only: [:edit, :update, :destroy]

  def create
    @comment = Comment.new comment_params
    @comment.discussion = Discussion.find params[:discussion_id]
    @comment.user = current_user
    if @comment.save
      redirect_to @comment.discussion
    else
      redirect_to @comment.discussion, notice: error_messages
    end
  end

  def edit
  end

  def update
    if @comment.update(comment_params)
      redirect_to @comment.discussion
    else
      redirect_to projects_path, notice: error_messages
    end
  end

  def destroy
    @discussion = @comment.discussion
    if @comment.destroy
      redirect_to @discussion
    else
      redirect_to projects_path, notice: error_messages
    end
  end

  private

  def get_comment
    @comment = Comment.find params[:id]
  end

  def comment_params
    params.require(:comment).permit(:body)
  end

  def error_messages
    @comment.errors.full_messages.join('; ')
  end

end
