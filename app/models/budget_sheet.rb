class BudgetSheet < ActiveRecord::Base
  belongs_to :user
  has_many :categories, dependent: :destroy

  validates_presence_of :name, :user

  scope :created_at_desc, ->{ order created_at: :desc }
end
