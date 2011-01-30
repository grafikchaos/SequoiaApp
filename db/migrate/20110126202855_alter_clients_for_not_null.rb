class AlterClientsForNotNull < ActiveRecord::Migration
  def self.up
    change_column(:clients, :name, :string, :null => false)
    change_column(:clients, :client_code, :string, :limit => 10, :null => false)
  end

  def self.down
    change_column(:clients, :name, :string, :null => true)
    change_column(:clients, :client_code, :string, :null => true)
  end
end
