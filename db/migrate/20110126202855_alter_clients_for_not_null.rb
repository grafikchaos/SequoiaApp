class AlterClientsForNotNull < ActiveRecord::Migration
  def self.up
    change_column(:clients, :name, :string, :null => false, :default => "")
    change_column(:clients, :client_code, :string, :limit => 10, :null => false, :default => "")
  end

  def self.down
    change_column(:clients, :name, :string, :null => true, :default => "NULL")
    change_column(:clients, :client_code, :string, :null => true, :default => "NULL")
  end
end
