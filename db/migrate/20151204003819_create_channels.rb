class CreateChannels < ActiveRecord::Migration
  def change
    create_table :channels do |t|
      t.string :name
      t.string :description
      t.string :image
      t.string :post_type
      t.string :rss_link
      t.boolean :approved

      t.timestamps null: false
    end
  end
end
