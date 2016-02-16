class Authentication
  def initialize(email:, token:)
    @email = email
    @token = token
  end

  def success?
    api_key.present?
  end

  def user
    @user ||= User.where(email: email).first_or_initialize
  end

  private

  attr_reader :email, :token

  def api_key
    user.api_keys.active.created_at_desc.find do |key|
      BCrypt::Password.new(key.secret) == token
    end
  end
end
