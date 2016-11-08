class CreateApiKey
  Result = Struct.new(:api_key, :token)

  TIME_TO_LIVE = 168

  def initialize(user_id:)
    @user_id = user_id
    @token   = SecureRandom.hex
  end

  def create!
    Result.new(api_key, token)
  end

  private

  attr_reader :user_id, :token

  def api_key
    ApiKey.create!(secret: secret, user_id: user_id, expired_at: expired_at)
  end

  def secret
    BCrypt::Password.create(token)
  end

  def expired_at
    Time.zone.now.advance(hours: TIME_TO_LIVE)
  end
end
