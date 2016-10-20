class UsersController < ApplicationController

  def session_create
    user = User.where(email: params[:email], password: params[:password]).first
    if user
      user.generate_token
      render json: {result: 0, user_id: user.id, token: user.token, message: 'successfully logged in'}
    else
      render json: {result: 1, message: "Invalid email or password"}
    end
  end

  def create
    user = User.new(user_params)
    if user.save
      user.generate_token
      render json: {result: 0, user_id: user.id, token: user.token, message: 'successfully signup'}
    else
      render json: {result: 1, message: "Error while submitting form"}
    end
  end

  def forgot_password
    user = User.find_by_email(params[:email])
    if user
      user.generate_reset_password_token
      render json: {result: 0}
    else
      render json: {result: 1, message: "Invalid email address."}
    end

  end

  def change_password
    user = User.find_by_token(params[:token])
    if user
      user.update_attributes(password: params[:password])
      render json: {result: 0}
    else
      render json: {result: 1, message: "Invalid token."}
    end
  end

  private

    def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :password, :country)
    end
end
