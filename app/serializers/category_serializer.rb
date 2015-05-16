class CategorySerializer < ActiveModel::Serializer
  attributes :id, :name, :budget_amount

  has_many :entries
end
