class AddClearanceToEntitiesAndUsers < ActiveRecord::Migration
  def self.up
    add_column :entities, :clearance, :integer, :null => false, :unsigned => true, :default => 3, :after => :name
    add_column :users, :clearance, :integer, :null => false, :unsigned => true, :default => 3, :after => :last_name
  end

  def self.down
    remove_column :entities, :clearance
    remove_column :users, :clearance
  end
end
