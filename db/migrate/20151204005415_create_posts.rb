class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.string :description
      t.string :link
      t.references :user, index: true, foreign_key: true
      t.references :channel, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
