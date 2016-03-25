class V1::UsersController < ApplicationController
  skip_before_action :authenticate_user!

  def create
    registration = Registration.new(user_attributes: user_params)

    if registration.save
      result = CreateApiKey.new(user_id: registration.user.id).create!

      render json: registration.user, token: result.token, status: 201
    else
      render json: { errors: [registration.error_message] }, status: 400
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
