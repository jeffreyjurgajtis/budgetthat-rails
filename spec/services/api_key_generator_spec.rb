require "rails_helper"

describe ApiKeyGenerator do
  describe '#token!' do
    it "returns a token" do
      user = create :user
      generator = ApiKeyGenerator.new(user_id: user.id)

      expect(generator.token!).to be_a String
    end

    it "creates an ApiKey" do
      user = create :user
      generator = ApiKeyGenerator.new(user_id: user.id)

      expect do
        generator.token!
      end.to change { user.api_keys.count }.by 1
    end

    it "raises an exception when invalid user_id id passed" do
      generator = ApiKeyGenerator.new(user_id: nil)

      expect do
        generator.token!
      end.to raise_error ActiveRecord::RecordInvalid
    end
  end
end
