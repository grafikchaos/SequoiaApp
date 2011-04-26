class AddIsSystemColumnToRole < ActiveRecord::Migration
  def self.up
    add_column :roles, :is_system, :boolean, :default => 0, :after => :name
  end

  def self.down
    remove_column :roles, :is_system
  end
end
