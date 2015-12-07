class AddAPIKeyToChannel < ActiveRecord::Migration
  def change
    add_column :channels, :api_key, :string
    add_index :channels, :api_key, unique: true
  end
end
