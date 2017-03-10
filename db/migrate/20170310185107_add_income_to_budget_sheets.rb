class AddIncomeToBudgetSheets < ActiveRecord::Migration
  def change
    add_column :budget_sheets, :income, :integer, default: 0
  end
end
