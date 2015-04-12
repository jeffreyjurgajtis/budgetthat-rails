require 'rails_helper'

RSpec.describe ApiKey, type: :model do
  describe "associations" do
    it { should belong_to :user }
  end

  describe "validations" do
    it { should validate_presence_of :access_token }
    it { should validate_presence_of :user }
    it { should validate_presence_of :expired_at }
  end
end
