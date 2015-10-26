class ApplicationMailer < ActionMailer::Base
  default from: "notifications@fuzzfinders.com"
  layout 'mailer'
end
