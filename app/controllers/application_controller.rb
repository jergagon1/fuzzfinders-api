class ApplicationController < ActionController::API
  helper_method :current_user

  def current_user
    User.first
    #hack for now, return first user until we handle decoupled auth
    #@current_user ||= User.find_by_id(session[:user])
  end
end
