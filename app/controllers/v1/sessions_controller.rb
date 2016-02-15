class V1::SessionsController < ApplicationController
  skip_before_action :authenticate_user!

  def create
    user = User.find_by_email session_params[:email]

    if user && user.authenticate(session_params[:password])
      render json: user, status: 201
    else
      render json: { errors: 'Invalid email/password' }, status: 400
    end
  end

  private

  def session_params
    params.require(:session).permit(:email, :password)
  end
end
