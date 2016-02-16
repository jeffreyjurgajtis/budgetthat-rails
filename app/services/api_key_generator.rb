class ApiKeyGenerator
  def initialize(user_id:)
    @user_id = user_id
    @token   = SecureRandom.hex
  end

  def token!
    create_api_key!
    token
  end

  private

  attr_reader :user_id, :token

  def create_api_key!
    ApiKey.create!(
      secret: BCrypt::Password.create(token),
      expired_at: Time.zone.now.advance(hours: ApiKey::TIME_TO_LIVE),
      user_id: user_id
    )
  end
end
