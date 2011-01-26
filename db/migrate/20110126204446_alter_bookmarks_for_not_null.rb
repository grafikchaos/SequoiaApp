class AlterBookmarksForNotNull < ActiveRecord::Migration
  def self.up
    change_column(:bookmarks, :user_id, :integer, :null => false, :default => 0)
  end

  def self.down
    change_column(:bookmarks, :user_id, :integer, :null => true, :default => 0)
  end
end
