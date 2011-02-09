class AlterProjectsForNotNull < ActiveRecord::Migration
  def self.up
    change_column(:projects, :name, :string, :null => false)
    change_column(:projects, :client_id, :integer, :null => false, :default => 0)
  end

  def self.down
    change_column(:projects, :name, :string, :null => true)
    change_column(:projects, :client_id, :integer, :null => true)
  end
end
