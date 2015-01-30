class FavoritesController < ApplicationController
  before_action :authenticate_user!

  def index
    @favorites = current_user.favorites
  end

  def create
    @project = Project.find(params[:project_id])
    @favorite = @project.favorites.new
    @favorite.user = current_user
    if @favorite.save
      redirect_to @project
    else
      redirect_to @project, notice: error_messages
    end
  end

  def destroy
    @project = Project.find(params[:project_id])
    @favorite = @project.favorites.find(params[:id])
    if @favorite.destroy
      redirect_to @project
    else
      redirect_to @project, notice: error_messages
    end
  end

  private

  def error_messages
    @favorite.errors.full_messages.join('; ')
  end

end
