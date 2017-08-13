class RemoveEntryCategoryIdNullConstraint < ActiveRecord::Migration
  def change
    change_column_null(:entries, :category_id, true)
  end
end
