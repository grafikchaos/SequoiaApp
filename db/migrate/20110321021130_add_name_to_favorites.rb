class AddNameToFavorites < ActiveRecord::Migration
  def self.up
    add_column :favorites, :name, :string, :after => :id, :null => true, :default => nil
  end

  def self.down
    remove_column :favorites, :name
  end
end
