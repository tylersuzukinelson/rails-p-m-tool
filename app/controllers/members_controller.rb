class MembersController < ApplicationController
  def create
    @project = Project.find params[:project_id]
    @member = @project.members.new
    @member.user = current_user
    if @member.save
      flash[:notice] = "Membership added!"
      redirect_to @project
    else
      flash[:alert] = error_messages
      redirect_to @project
    end
  end

  def destroy
    @member = Member.find params[:id]
    @project = Project.find params[:project_id]
    if @member.destroy
      flash[:notice] = "Removed membership!"
      redirect_to @project
    else
      flash[:alert] = error_messages
      redirect_to @project
    end
  end

  private

  def error_messages
    @member.errors.full_messages.join('; ')
  end
end
