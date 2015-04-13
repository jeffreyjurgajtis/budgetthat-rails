require 'rails_helper'

RSpec.describe Category, type: :model do
  describe "validations" do
    it { should validate_presence_of :name }
    it { should validate_presence_of :budget_sheet }
    it { should validate_presence_of :budget_amount }
  end

  describe "associations" do
    it { should belong_to :budget_sheet }
  end
end
