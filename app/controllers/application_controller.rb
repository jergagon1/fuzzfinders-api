class ApplicationController < ActionController::API
  # include ::ActionController::Serialization

  def find_user params
    @user ||= User.find_by(
      email: params[:email],
      password_hash: params[:password_hash],
    )
  end

end