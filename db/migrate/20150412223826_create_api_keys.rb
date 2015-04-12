class CreateApiKeys < ActiveRecord::Migration
  def change
    create_table :api_keys do |t|
      t.string :access_token, null: false
      t.datetime :expired_at, null: false
      t.integer :user_id,     null: false

      t.timestamps null: false
    end

    add_index :api_keys, :access_token, unique: true
    add_index :api_keys, :user_id
  end
end
