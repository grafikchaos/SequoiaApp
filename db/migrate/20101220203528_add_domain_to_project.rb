class AddDomainToProject < ActiveRecord::Migration
  def self.up
    add_column :projects, :domain, :string, :after => :name
  end

  def self.down
    remove_column :projects, :domain
  end
end
