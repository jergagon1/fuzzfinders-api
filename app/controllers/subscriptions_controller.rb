class SubscriptionsController < ApplicationController
  def index
    render json: current_user.subscribed_reports.ids
  end
end
