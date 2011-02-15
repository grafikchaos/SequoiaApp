class AddRoleToUserTable < ActiveRecord::Migration
  def self.up
    add_column('users', 'role', :string, { :limit => 20, :default => 'staff', :after => 'username' } )
  end

  def self.down
    remove_column('users', 'role')
  end
end
