require File.expand_path('../boot', __FILE__)

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "sprockets/railtie"
# require "rails/test_unit/railtie"
require "httparty"
require "json"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module FuzzfindersApi
  class Application < Rails::Application

    config.active_record.raise_in_transactional_callbacks = true

    config.middleware.insert_before 0, "Rack::Cors" do
      allow do
        origins '*'
        resource '*', :headers => :any, :methods => [:get, :put, :delete, :post, :options]
      end
    end

    config.action_mailer.delivery_method = :smtp
    config.action_mailer.smtp_settings = {
      address: ENV['EMAIL_SMTP'],
      port: 465,
      # domain: ENV['MAILGUN_DOMAIN'], # CHANGE THIS
      # authentication: "plain",
      enable_starttls_auto: true,
      user_name: ENV['EMAIL_USERNAME'], # CHANGE THIS
      password: ENV['EMAIL_PASSWORD'] # CHANGE THIS
    }

  end
end
