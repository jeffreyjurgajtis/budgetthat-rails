class CategorySerializer < ActiveModel::Serializer
  attributes :id, :name, :budget_amount

  has_many :entries

  def entries
    object.entries.created_at_desc
  end
end
