class AddBudgetSheetIdToEntries < ActiveRecord::Migration
  def change
    add_column :entries, :budget_sheet_id, :integer

    add_index :entries, :budget_sheet_id
  end
end
