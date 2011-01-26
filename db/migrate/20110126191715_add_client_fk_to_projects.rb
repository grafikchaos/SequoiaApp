class AddClientFkToProjects < ActiveRecord::Migration
  def self.up
    add_foreign_key(:projects, :clients, :name => 'fk_projects_clients', :dependent => :delete)
  end

  def self.down
    remove_foreign_key(:projects, :name => 'fk_projects_clients')
  end
end
