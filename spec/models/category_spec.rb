require 'rails_helper'

RSpec.describe Category, type: :model do
  describe "validations" do
    it { should validate_presence_of :name }
    it { should validate_presence_of :budget_sheet }
    it { should validate_numericality_of :budget_amount }
    it { should_not allow_value(-1).for :budget_amount }

    it "prevent destroy when associated entries exist" do
      category = create :category
      create :entry, category: category
      expect(category.destroy).to eq false
    end
  end

  describe "associations" do
    it { should belong_to :budget_sheet }
    it { should have_many :entries }
  end
end
