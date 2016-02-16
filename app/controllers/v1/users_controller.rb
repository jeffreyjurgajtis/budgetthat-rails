class V1::UsersController < ApplicationController
  skip_before_action :authenticate_user!

  def create
    user = User.new user_params

    if user.save
      result = CreateApiKey.new(user_id: user.id).create!

      render json: user, token: result.token, status: 201
    else
      render json: { errors: user.errors.messages }, status: 400
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
