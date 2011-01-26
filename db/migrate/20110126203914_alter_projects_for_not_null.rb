class AlterProjectsForNotNull < ActiveRecord::Migration
  def self.up
    change_column(:projects, :name, :string, :null => false, :default => "")
    change_column(:projects, :client_id, :integer, :null => false, :default => 0)
  end

  def self.down
    change_column(:projects, :name, :string, :null => true, :default => "NULL")
    change_column(:projects, :client_id, :integer, :null => true, :default => "NULL")
  end
end
