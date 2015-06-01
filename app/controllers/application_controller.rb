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

  before_filter :cors_preflight_check
  after_filter :cors_set_access_control_headers

  def cors_set_access_control_headers
    headers['Access-Control-Request-Method'] = '*'
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Allow-Methods'] = 'POST, GET, PUT, DELETE, OPTIONS'
    headers['Access-Control-Allow-Headers'] = 'Origin, Content-Type, Accept, Authorization, Token'
    headers['Access-Control-Max-Age'] = '1728000'
  end

  def cors_preflight_check
    if request.method == 'OPTIONS'
      headers['Access-Control-Allow-Origin'] = '*'
      headers['Access-Control-Request-Method'] = '*'

      headers['Access-Control-Allow-Methods'] = 'POST, GET, PUT, DELETE, OPTIONS'
      headers['Access-Control-Allow-Headers'] = 'X-Requested-With, X-Prototype-Version, Token'
      headers['Access-Control-Max-Age'] = '1728000'

      render :text => '', :content_type => 'text/plain'
    end
end
end
