require 'rails_helper'

RSpec.describe Category, type: :model do
  describe "validations" do
    it { should validate_presence_of :name }
    it { should validate_presence_of :budget_sheet }
    it { should validate_numericality_of :budget_amount }
    it { should_not allow_value(-1).for :budget_amount }
  end

  describe "associations" do
    it { should belong_to :budget_sheet }
    it { should have_many :entries }
  end

  describe "#destroy" do
    it "deletes associated entries" do
      category = create :category
      entry    = create :entry, category: category

      expect do
        category.destroy
      end.to change { Entry.count }.by -1
    end
  end
end
