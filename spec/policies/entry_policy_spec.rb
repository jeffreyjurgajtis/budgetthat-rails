require "rails_helper"

RSpec.describe EntryPolicy do
  let(:user) { create :user }
  let(:budget_sheet) { create :budget_sheet, user: user }
  let(:category) { create :category, budget_sheet: budget_sheet }
  let!(:entry) { create :entry, category: category }

  let(:random_user) { create :user }

  describe "#create?" do
    let(:new_entry) { build :entry, category: category }

    it "returns true when user owns budget sheet" do
      policy = EntryPolicy.new(user, new_entry)
      expect(policy.create?).to eq true
    end

    it "returns false when user is unknown" do
      policy = EntryPolicy.new(random_user, new_entry)
      expect(policy.create?).to eq false
    end
  end

  describe "#update?" do
    it "returns true when user owns budget sheet" do
      policy = EntryPolicy.new(user, entry)
      expect(policy.update?).to eq true
    end

    it "returns false when user is unknown" do
      policy = EntryPolicy.new(random_user, entry)
      expect(policy.update?).to eq false
    end
  end

  describe "#destroy?" do
    it "returns true when user owns budget sheet" do
      policy = EntryPolicy.new(user, entry)
      expect(policy.destroy?).to eq true
    end

    it "returns false when user is unknown" do
      policy = EntryPolicy.new(random_user, entry)
      expect(policy.destroy?).to eq false
    end
  end
end
