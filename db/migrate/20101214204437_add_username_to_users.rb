class AddUsernameToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :username, :string, :null => FALSE, :after => 'id'
  end

  def self.down
    remove_column :users, :username
  end
end
