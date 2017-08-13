class Category < ActiveRecord::Base
  belongs_to :budget_sheet
  has_many :entries

  validates_presence_of :budget_sheet, :name
  validates_numericality_of :budget_amount, greater_than_or_equal_to: 0

  scope :created_at_asc, -> { order created_at: :asc }
end
