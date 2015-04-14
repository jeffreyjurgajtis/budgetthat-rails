require 'rails_helper'

RSpec.describe Entry, type: :model do
  describe "validations" do
    it { should validate_presence_of :occurred_on }
    it { should validate_presence_of :category }
    it { should validate_numericality_of :amount }
  end

  describe "associations" do
    it { should belong_to :category }
  end
end
