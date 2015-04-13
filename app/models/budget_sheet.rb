class BudgetSheet < ActiveRecord::Base
  belongs_to :user

  validates_presence_of :name, :user

  scope :created_at_asc, ->{ order created_at: :asc }
end
