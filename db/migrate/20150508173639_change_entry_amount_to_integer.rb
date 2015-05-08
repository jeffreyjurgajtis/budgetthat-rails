class ChangeEntryAmountToInteger < ActiveRecord::Migration
  def change
    remove_column(
      :entries,
      :amount,
      :decimal,
      null: false, 
      precision: 8,
      scale: 2,
      default: 0
    )

    add_column(:entries, :amount, :integer, null: false, default: 0)
  end
end
