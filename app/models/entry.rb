class Entry < ActiveRecord::Base
  belongs_to :category

  validates_presence_of :category, :description, :occurred_on
  validates_numericality_of :amount, greater_than_or_equal_to: 0

  scope :created_at_desc, -> { order created_at: :desc }
end
