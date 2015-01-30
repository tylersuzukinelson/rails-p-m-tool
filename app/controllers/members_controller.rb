class MembersController < ApplicationController
  def create
    @project = Project.find params[:project_id]
    @member = @project.members.new
    @member.user = current_user
    if @member.save
      redirect_to @project
    else
      redirect_to @project, notice: error_messages
    end
  end

  def destroy
    @member = Member.find params[:id]
    @project = Project.find params[:project_id]
    if @member.destroy
      redirect_to @project
    else
      redirect_to @project, notice: error_messages
    end
  end

  private

  def error_messages
    @member.errors.full_messages.join('; ')
  end
end
