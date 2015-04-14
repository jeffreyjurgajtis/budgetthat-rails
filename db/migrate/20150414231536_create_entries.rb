class CreateEntries < ActiveRecord::Migration
  def change
    create_table :entries do |t|
      t.string :description
      t.date :occurred_on,    null: false
      t.integer :category_id, null: false
      t.decimal :amount,      null: false, default: 0, precision: 8, scale: 2

      t.timestamps null: false
    end

    add_index :entries, :category_id
  end
end
