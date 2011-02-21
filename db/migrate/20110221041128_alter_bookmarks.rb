class AlterBookmarks < ActiveRecord::Migration
  def self.up
    add_column :bookmarks, :client_id, :integer, :before => :path
    add_column :bookmarks, :project_id, :integer, :before => :path
    rename_column :bookmarks, :path, :query
    change_table :bookmarks do |t|
      t.foreign_key :projects, :dependent => :delete
      t.foreign_key :clients, :dependent => :delete
    end
  end

  def self.down
    remove_column :bookmarks, :client_id
    remove_column :bookmarks, :project_id
    rename_column :bookmarks, :query, :path
    remove_foreign_key(:entities, :name => 'bookmarks_client_id_fk')
    remove_foreign_key(:entities, :name => 'bookmarks_project_id_fk')
  end
end
