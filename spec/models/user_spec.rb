require 'rails_helper'

RSpec.describe User, type: :model do
  describe "validations" do
    it { should validate_presence_of :password }
    it { should validate_uniqueness_of :email }
    it { should allow_value("email@example.com").for :email }
    it { should_not allow_value("example.com").for :email }
  end
end
