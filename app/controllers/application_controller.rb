class ApplicationController < ActionController::API
  before_action :authenticate_user!

  protected

  def authenticate_user!
    head 401 unless current_user
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
