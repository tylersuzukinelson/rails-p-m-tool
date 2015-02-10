class CommentsController < ApplicationController

  before_action :authenticate_user!
  before_action :get_comment, only: [:edit, :update, :destroy]

  def create
    @comment = Comment.new comment_params
    @comment.discussion = Discussion.find params[:discussion_id]
    @comment.user = current_user
    if @comment.save
      if @comment.user_id != @comment.discussion.user_id
        PmToolerMailer.notify_discussion_owner(@comment).deliver_later
      end
      respond_to do |format|
        format.html { redirect_to @comment.discussion }
        format.js { render }
      end
    else
      respond_to do |format|
        format.html { redirect_to @comment.discussion, notice: error_messages }
        format.js { render }
      end
    end
  end

  def edit
    respond_to do |format|
      format.html { render }
      format.js { render }
    end
  end

  def update
    if @comment.update(comment_params)
      respond_to do |format|
        format.html { redirect_to @comment.discussion }
        format.js { render }
      end
    else
      respond_to do |format|
        format.html { redirect_to projects_path, notice: error_messages }
        format.js { render }
      end
    end
  end

  def destroy
    @discussion = @comment.discussion
    if @comment.destroy
      respond_to do |format|
        format.html { redirect_to @discussion }
        format.js { render }
      end
    else
      respond_to do |format|
        format.html { redirect_to projects_path, notice: error_messages }
        format.js { render }
      end
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
