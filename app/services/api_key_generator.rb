class ApiKeyGenerator
  attr_reader :user_id

  def initialize(user_id)
    @user_id = user_id
  end

  def first_or_create
    ApiKey.where(user_id: user_id).active.first || create
  end

  private

  def create
    ApiKey.create(
      access_token: access_token,
      expired_at: ApiKey::TIME_TO_LIVE.from_now,
      user_id: user_id
    )
  end

  def access_token
    begin
      new_token = SecureRandom.hex
    end while ApiKey.exists?(access_token: new_token)

    new_token
  end
end
