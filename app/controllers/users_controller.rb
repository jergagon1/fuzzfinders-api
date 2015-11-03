class UsersController < ApplicationController
  # def create
  #   @user = User.create user_params
  #   session[:user_id] = @user.id
  #   p NotificationEmailer.welcome_email(@user)
  #   render json: @user
  # end
  #
  # def logged_in
  #   find_user params
  #   if @user and @user.logged_in
  #     render json: @user
  #   else
  #     render json: {logged_in: false}, status: 401
  #   end
  # end
  #
  # def log_in
  #   find_user params
  #   if @user
  #     @user.update_attributes(logged_in: true)
  #     session[:user_id] = @user.id
  #     render json: @user
  #   end
  # end
  #
  # def log_out
  #   find_user params
  #   if @user
  #     @user.update_attributes(logged_in: false)
  #     session[:user_id] = nil
  #   end
  # end
  #
  def wags
    @user = User.find_by(
      authentication_token: params[:user_token],
      email: params[:user_email]
    )

    if @user
      render json: { wags: @user.wags }
    end
  end
  #
  # private
  # def user_params
  #   params.require(:user).permit(:username, :email, :password_hash, :zipcode)
  # end
end
