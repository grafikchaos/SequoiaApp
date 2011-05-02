class RenameAssignmentsToUserRoles < ActiveRecord::Migration
  def self.up
    rename_table :assignments, :user_roles
    remove_column :user_roles, :id
    remove_column :user_roles, :created_at
    remove_column :user_roles, :updated_at
  end

  def self.down
    rename_table :user_roles, :assignments
    add_column :assignments, :id, :integer
    add_column :assignments, :created_at, :integer
    add_column :assignments, :updated_at, :integer
  end
end
