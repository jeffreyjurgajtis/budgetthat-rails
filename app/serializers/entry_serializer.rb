class EntrySerializer < ActiveModel::Serializer
  attributes :id, :category_id, :description, :amount, :occurred_on

  def occurred_on
    object.occurred_on.to_s(:year_month_day)
  end
end
