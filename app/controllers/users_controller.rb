class UsersController < ApplicationController
  before_filter :load_user

  def update_coordinates
    if @user && @user.update_coordinates!(params[:latitude], params[:longitude])
      render json: { result: 'Ok' }
    else
      render json: { error: 'some error' }
    end
  end

  def wags
    if @user
      render json: { wags: @user.wags }
    end
  end

  private

  def load_user
    @user = User.find_by(
      authentication_token: params[:user_token],
      email: params[:user_email]
    )
  end
end
