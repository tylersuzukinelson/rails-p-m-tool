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

end
