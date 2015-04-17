class ApplicationController < ActionController::API
  include Pundit

  before_action :authenticate_user!

  rescue_from Pundit::NotAuthorizedError, with: :user_forbidden!

  protected

  def authenticate_user!
    head 401 unless current_user
  end

  def user_forbidden!
    head 403
  end

  def current_user
    @current_user ||= api_key.try(:user)
  end

  def api_key
    ApiKey.active.find_by_access_token(access_token_from_header)
  end

  def access_token_from_header
    request.headers['X-ACCESS-TOKEN']
  end
end
