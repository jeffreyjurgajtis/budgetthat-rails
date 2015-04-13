class CreateBudgetSheets < ActiveRecord::Migration
  def change
    create_table :budget_sheets do |t|
      t.string :name,     null: false
      t.integer :user_id, null: false

      t.timestamps null: false
    end

    add_index :budget_sheets, :user_id
  end
end
