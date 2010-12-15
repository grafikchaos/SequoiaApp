class CreateBookmarks < ActiveRecord::Migration
  def self.up
    create_table :bookmarks do |t|
      t.primary_key :id
      t.integer :user_id
      t.string :path

      t.timestamps
    end
  end

  def self.down
    drop_table :bookmarks
  end
end
