class AddApiKeysSecret < ActiveRecord::Migration
  def change
    add_column :api_keys, :secret, :string, null: false
  end
end
