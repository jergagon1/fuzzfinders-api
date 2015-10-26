class NotificationEmailer < ApplicationMailer
  default from: "notifications@fuzzfinders.com"

  def welcome_email(recipient)
    mg_client = Mailgun::Client.new ENV['MAILGUN_API_KEY']
    message_params = {
      :from    => 'notifications@fuzzfinders.com',
      :to      => recipient.email,
      :subject => 'Welcome to Fuzzfinders!',
      :text    => 'Welcome to Fuzzfinders!'}
    mg_client.send_message ENV['MAILGUN_DOMAIN'], message_params
  end

end