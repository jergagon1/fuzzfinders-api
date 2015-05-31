class ApplicationController < ActionController::API
  helper_method :current_user

  #make a call to fuzzfriends-api to determine whether user is logged_in
  #good proof of concept of apis making requests to each other
  #but not secure
  def current_user email, password_hash
    url = "http://localhost:3000/api/v1/logged_in?email=#{email}&password_hash=#{password_hash}"
    response = HTTParty.get(url)
    data = JSON.parse(response.body)
    if data["email"] == email and data["password_hash"] == password_hash
      @current_user ||= data
    end
  end
end
