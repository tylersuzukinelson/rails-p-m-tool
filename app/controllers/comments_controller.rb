class CommentsController < ApplicationController

  def create
    @comment = Comment.new comment_params
    @comment.discussion = Discussion.find params[:discussion_id]
    if @comment.save
      redirect_to @comment.discussion
    else
      redirect_to @comment.discussion, notice: error_messages
    end
  end

  def edit
    @comment = Comment.find params[:id]
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end

  def error_messages
    @comment.errors.full_messages.join('; ')
  end

end
