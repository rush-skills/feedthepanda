class ChangeDescriptionToText < ActiveRecord::Migration
  def change
  	remove_column :posts, :description, :string
  	add_column :posts, :description, :text
  	remove_column :channels, :description, :string
  	add_column :channels, :description, :text
  end
end
