class Entry < ActiveRecord::Base
  belongs_to :category
  belongs_to :budget_sheet

  validates_presence_of :description, :occurred_on, :budget_sheet
  validates_numericality_of :amount, greater_than_or_equal_to: 0

  scope :created_at_desc, -> { order created_at: :desc }
end
