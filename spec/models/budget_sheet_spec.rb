require 'rails_helper'

RSpec.describe BudgetSheet, type: :model do
  describe "associations" do
    it { should belong_to :user }
    it { should have_many :categories }
    it { should have_many :entries }
  end

  describe "validations" do
    it { should validate_presence_of :name }
    it { should validate_presence_of :user }
  end

  describe "#destroy" do
    it "deletes associated entries" do
      budget_sheet = create :budget_sheet
      category = create :category, budget_sheet: budget_sheet
      entry = create :entry, budget_sheet: budget_sheet, category: category

      expect do
        budget_sheet.destroy
      end.to change { Entry.count }.by -1
    end

    it "deletes associated categories" do
      budget_sheet = create :budget_sheet
      category = create :category, budget_sheet: budget_sheet

      expect do
        budget_sheet.destroy
      end.to change { Category.count }.by -1
    end
  end
end
