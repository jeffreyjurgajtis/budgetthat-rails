class Authentication
  def initialize(email:, token:)
    @email = email
    @token = token
  end

  def success?
    api_key.present? && BCrypt::Password.new(api_key.secret) == token
  end

  def user
    @user ||= User.find_by(email: email)
  end

  private

  attr_reader :email, :token

  def api_key
    @api_key ||= ApiKey.active.where(user: user).created_at_desc.first
  end
end
