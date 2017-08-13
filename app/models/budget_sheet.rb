class BudgetSheet < ActiveRecord::Base
  belongs_to :user
  has_many :categories, dependent: :destroy
  has_many :entries, dependent: :destroy

  validates_presence_of :name, :user, :income

  scope :created_at_desc, ->{ order created_at: :desc }
end
