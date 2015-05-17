require "rails_helper"

RSpec.describe CategoryPolicy do
  let(:user) { create :user }
  let(:budget_sheet) { create :budget_sheet, user: user }
  let!(:category) { create :category, budget_sheet: budget_sheet }

  let(:random_user) { create :user }

  describe "#create?" do
    let(:new_category) { build :category, budget_sheet: budget_sheet }

    it "returns true when user owns budget sheet" do
      policy = CategoryPolicy.new(user, new_category)
      expect(policy.create?).to eq true
    end

    it "returns false when user is unknown" do
      policy = CategoryPolicy.new(random_user, new_category)
      expect(policy.create?).to eq false
    end
  end

  describe "#update?" do
    it "returns true when user owns budget sheet" do
      policy = CategoryPolicy.new(user, category)
      expect(policy.update?).to eq true
    end

    it "returns false when user is unknown" do
      policy = CategoryPolicy.new(random_user, category)
      expect(policy.update?).to eq false
    end
  end

  describe "#destroy?" do
    it "returns true when user owns budget sheet" do
      policy = CategoryPolicy.new(user, category)
      expect(policy.destroy?).to eq true
    end

    it "returns false when user is unknown" do
      policy = CategoryPolicy.new(random_user, category)
      expect(policy.destroy?).to eq false
    end
  end
end
