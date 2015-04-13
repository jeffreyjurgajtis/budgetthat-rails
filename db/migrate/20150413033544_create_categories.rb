class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :name, null: false
      t.decimal :budget_amount, null: false, precision: 8, scale: 2, default: 0
      t.integer :budget_sheet_id, null: false

      t.timestamps null: false
    end

    add_index :categories, :budget_sheet_id
  end
end
