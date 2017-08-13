class EntrySerializer < ActiveModel::Serializer
  attributes(
    :id,
    :budget_sheet,
    :category,
    :description,
    :amount,
    :occurred_on,
    :created_at
  )

  def category
    @object.category_id
  end

  def budget_sheet
    @object.budget_sheet_id
  end
end
