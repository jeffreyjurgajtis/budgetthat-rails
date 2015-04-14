class Entry < ActiveRecord::Base
  belongs_to :category

  validates_presence_of :category, :description, :occurred_on
  validates_numericality_of :amount
end
