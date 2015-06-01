class ApplicationController < ActionController::API
  helper_method :current_user
  before_action :current_user

  #make a call to fuzzfriends-api to determine whether user is logged_in
  #good proof of concept of apis making requests to each other
  #but not secure
  def current_user
    url = "http://localhost:3000/api/v1/logged_in?email=#{params[:email]}&password_hash=#{params[:password_hash]}"
    response = HTTParty.get(url)
    data = JSON.parse(response.body)
    unless data["logged_in"]
      render json: "invalid credentials", status: 401
    else
      @current_user ||= data
    end
  end
end
