class ApplicationController < ActionController::API
  include Pundit

  before_action :authenticate_user!

  rescue_from Pundit::NotAuthorizedError, with: :user_forbidden!

  protected

  def authenticate_user!
    head 401 unless authentication.success?
  end

  def user_forbidden!
    head 403
  end

  def authentication
    @authentication ||= Authentication.new(email: email, token: token)
  end

  def current_user
    authentication.user
  end

  def email
    request.headers['X-USER-EMAIL']
  end

  def token
    request.headers['X-USER-TOKEN']
  end
end
