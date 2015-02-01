class ProjectsController < ApplicationController

  before_action :authenticate_user!
  before_action :get_project, only: [:show, :edit, :update, :destroy]

  def index
    @projects = Project.all
  end

  def create
    @project = Project.new permitted_params
    @project.user = current_user
    if @project.save
      redirect_to @project
    else
      redirect_to new_project_path, notice: error_messages
    end
  end

  def new
    @project = Project.new
  end

  def edit
  end

  def show
  end

  def update
    if @project.update(permitted_params)
      redirect_to @project
    else
      redirect_to edit_project_path(@project), notice: error_messages
    end
  end

  def destroy
    if @project.destroy
      redirect_to projects_path
    else
      redirect_to @project, notice: error_messages
    end
  end

  def search
    @projects = Project.where('title LIKE ? OR body LIKE ?', "%#{params['search_term']}%", "%#{params['search_term']}%")
  end

  private

  def permitted_params
    params.require(:project).permit(:title, :body, :due_date)
  end

  def error_messages
    @project.errors.full_messages.join('; ')
  end

  def get_project
    @project = Project.find params[:id]
  end

end
