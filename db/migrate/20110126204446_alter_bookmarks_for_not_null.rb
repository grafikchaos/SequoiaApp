class AlterBookmarksForNotNull < ActiveRecord::Migration
  def self.up
    change_column(:bookmarks, :user_id, :integer, :null => false)
  end

  def self.down
    change_column(:bookmarks, :user_id, :integer, :null => true)
  end
end
