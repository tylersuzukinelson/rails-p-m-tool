class PmToolerMailer < ApplicationMailer

  def notify_discussion_owner(comment)
    @comment = comment
    @discussion = @comment.discussion
    @user = @discussion.user
    mail to: @user.email, subject: "Someone commented on your discussion!"
  end

  def notify_task_owner(task)
    @task = task
    @user = @task.user
    @completed_by = User.find @task.completed_by
    mail to: @user.email, subject: "Someone completed one of your tasks!"
  end

  def daily_summary(project_id)
    @project = Project.find project_id
    @user = @project.user
    @tasks = @project.tasks.where("created_at > ?", Time.now - 1.day)
    @discussions = @project.discussions.where("created_at > ?", Time.now - 1.day)
    mail to: @user.email, subject: "Your project has been updated!"
  end

end
