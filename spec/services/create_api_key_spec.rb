require "rails_helper"

describe CreateApiKey do
  describe '#create!' do
    it "creates an ApiKey" do
      user = create :user
      generator = CreateApiKey.new(user_id: user.id)

      expect do
        generator.create!
      end.to change { user.api_keys.count }.by 1
    end

    it "raises an exception when invalid user_id id passed" do
      generator = CreateApiKey.new(user_id: nil)

      expect do
        generator.create!
      end.to raise_error ActiveRecord::RecordInvalid
    end
  end
end
