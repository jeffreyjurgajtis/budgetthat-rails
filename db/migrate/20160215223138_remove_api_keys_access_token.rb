class RemoveApiKeysAccessToken < ActiveRecord::Migration
  def change
    remove_column :api_keys, :access_token, :string, null: false, default: ""
  end
end
