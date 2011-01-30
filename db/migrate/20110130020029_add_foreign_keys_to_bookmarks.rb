class AddForeignKeysToBookmarks < ActiveRecord::Migration
  def self.up
    change_table :bookmarks do |t|
      t.foreign_key :users, :dependent => :delete
    end
    
  end

  def self.down
    remove_foreign_key(:bookmarks, :name => 'bookmarks_user_id_fk')
  end
end
