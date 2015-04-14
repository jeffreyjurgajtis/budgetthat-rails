class Category < ActiveRecord::Base
  belongs_to :budget_sheet
  has_many :entries, dependent: :restrict_with_error

  validates_presence_of :budget_sheet, :budget_amount, :name

  scope :created_at_asc, -> { order created_at: :asc }
end
