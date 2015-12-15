class BudgetSheetSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers

  attributes :id, :name, :links

  def links
    { categories: budget_sheet_categories_path(object.id) }
  end
end
