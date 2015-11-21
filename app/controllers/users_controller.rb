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

  def update
    # do not change password if it is empty
    pp = permitted_params

    pp = if pp[:password].present? || pp[:password_confirmation].present?
           pp
         else
           pp.except(:password_confirmation, :password)
         end

    @user.update pp

    if @user.valid?
      render json: { status: 'Ok', user: @user }
    else
      render json: { status: 'Error', errors: @user.errors }
    end
  end

  private

  def permitted_params
    params.required(:user).permit(
      :username, :password,
      :password_confirmation, :zipcode,
      :image
    )
  end

  def load_user
    @user = User.find_by(
      authentication_token: params[:user_token],
      email: params[:user_email]
    )
  end
end
