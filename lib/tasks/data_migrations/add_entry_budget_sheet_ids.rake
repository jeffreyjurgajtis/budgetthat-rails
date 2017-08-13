namespace :data_migrations do
  task add_entry_budget_sheet_ids: :environment do
    entries = Entry
      .joins(:category)
      .select("entries.*, categories.budget_sheet_id AS category_budget_sheet_id")

    entries.find_each do |entry|
      entry.update_column(:budget_sheet_id, entry.category_budget_sheet_id)
    end
  end
end
