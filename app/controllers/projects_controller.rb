class ProjectsController < ApplicationController

  def index
    @projects = Project.all
  end

  def create
    @project = Project.new permitted_params
    if @project.save
      redirect_to @project
    else
      redirect_to new_project_path, notice: error_messages
    end
  end

  def new
    @project = Project.new
  end

  private

  def permitted_params
    params.require(:project).permit(:title, :body)
  end

  def error_messages
    @project.errors.full_messages.join('; ')
  end

end
