class AddDisplaySavingsToBudgetSheets < ActiveRecord::Migration
  def change
    add_column :budget_sheets, :display_savings, :boolean, default: true
  end
end
