class BudgetSheetSerializer < ActiveModel::Serializer
  attributes :id, :name

  has_many :categories

  def categories
    object.categories.created_at_asc
  end
end
