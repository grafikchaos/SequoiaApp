class AddFirstNameAndLastNameToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :first_name, :string, :after => :email
    add_column :users, :last_name, :string, :after => :first_name
  end

  def self.down
    remove_column :users, :last_name
    remove_column :users, :first_name
  end
end
