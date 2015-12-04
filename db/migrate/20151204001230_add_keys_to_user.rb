class AddKeysToUser < ActiveRecord::Migration
  def change
    add_column :users, :email, :string
    add_column :users, :avatar, :string
    add_column :users, :gcm_token, :string
    add_column :users, :api_key, :string
    add_column :users, :admin, :boolean
  end
end
