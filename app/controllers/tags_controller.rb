class TagsController < ApplicationController
  def show
    show_title = Tag.find(params[:id]).title
    @tags = current_user.tags.where("title = ?", show_title)
  end

  def create
    @project = Project.find params[:project_id]
    @tag = @project.tags.new permitted_params
    @tag.user = current_user
    if @tag.save
      redirect_to @project
    else
      redirect_to @project, notice: error_messages
    end
  end

  def destroy
    @project = Project.find params[:project_id]
    @tag = Tag.find params[:id]
    if @tag.destroy
      redirect_to @project
    else
      redirect_to @project, notice: error_messages
    end
  end

  private

  def error_messages
    @tag.errors.full_messages.join('; ')
  end

  def permitted_params
    params.require(:tag).permit(:title)
  end
end
