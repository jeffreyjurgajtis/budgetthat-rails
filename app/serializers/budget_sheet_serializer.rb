class BudgetSheetSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers

  attributes :id, :name, :created_at, :income, :display_savings, :links

  def links
    {
      categories: budget_sheet_categories_path(object.id),
      entries: budget_sheet_entries_path(object.id)
    }
  end
end
