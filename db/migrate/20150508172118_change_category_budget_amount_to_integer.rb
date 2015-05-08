class ChangeCategoryBudgetAmountToInteger < ActiveRecord::Migration
  def change
    remove_column(
      :categories,
      :budget_amount,
      :decimal,
      null: false, 
      precision: 8,
      scale: 2,
      default: 0
    )

    add_column(:categories, :budget_amount, :integer, null: false, default: 0)
  end
end
