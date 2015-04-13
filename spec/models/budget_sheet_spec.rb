require 'rails_helper'

RSpec.describe BudgetSheet, type: :model do
  describe "associations" do
    it { should belong_to :user }
    it { should have_many :categories }
  end

  describe "validations" do
    it { should validate_presence_of :name }
    it { should validate_presence_of :user }
  end
end
