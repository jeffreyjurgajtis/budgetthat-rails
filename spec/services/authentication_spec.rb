require "rails_helper"

describe Authentication do
  describe "success?" do
    it "returns true when valid email and token are passed" do
      user    = create :user
      token   = SecureRandom.hex
      api_key = create(
        :api_key,
        user: user,
        expired_at: 2.hours.from_now,
        secret: BCrypt::Password.create(token)
      )

      authentication = Authentication.new(email: user.email, token: token)

      expect(authentication.success?).to eq true
    end

    it "returns false when email is valid and token is not" do
      user    = create :user
      api_key = create(
        :api_key,
        user: user,
        expired_at: 2.hours.from_now,
        secret: BCrypt::Password.create(SecureRandom.hex)
      )

      authentication = Authentication.new(email: user.email, token: "invalid")

      expect(authentication.success?).to eq false
    end

    it "returns false when invalid email is passed" do
      user    = create :user
      token   = SecureRandom.hex
      api_key = create(
        :api_key,
        user: user,
        expired_at: 2.hours.from_now,
        secret: BCrypt::Password.create(token)
      )

      authentication = Authentication.new(email: "invalid", token: token)

      expect(authentication.success?).to eq false
    end

    it "returns false when nil token is passed" do
      user    = create :user
      api_key = create(
        :api_key,
        user: user,
        expired_at: 2.hours.from_now,
        secret: BCrypt::Password.create(SecureRandom.hex)
      )

      authentication = Authentication.new(email: user.email, token: nil)

      expect(authentication.success?).to eq false
    end

    it "returns false when valid email and expired token are passed" do
      user    = create :user
      token   = SecureRandom.hex
      api_key = create(
        :api_key,
        user: user,
        expired_at: 72.hours.ago,
        secret: BCrypt::Password.create(token)
      )

      authentication = Authentication.new(email: user.email, token: token)

      expect(authentication.success?).to eq false
    end

  end
end
