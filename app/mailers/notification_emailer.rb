class NotificationEmailer < ApplicationMailer
  # notify user about new comment
  def new_comment(comment, user)
    @comment = comment

    mail to: user.email, subject: 'New comment'
  end

  def welcome_email(recipient)
    mail to: recipient.email, subject: 'Welcome to Fuzzfinders!'
  end
end
