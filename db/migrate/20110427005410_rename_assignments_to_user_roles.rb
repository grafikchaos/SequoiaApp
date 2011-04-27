class RenameAssignmentsToUserRoles < ActiveRecord::Migration
  def self.up
    rename_table :assignments, :user_roles
    remove_column :user_roles, :id
  end

  def self.down
    rename_table :user_roles, :assignments
    add_column :assignments, :id, :integer
  end
end
