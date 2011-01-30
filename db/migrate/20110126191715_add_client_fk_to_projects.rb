class AddClientFkToProjects < ActiveRecord::Migration
  def self.up
    change_table :projects do |t|
      t.foreign_key :clients, :dependent => :delete
    end
  end

  def self.down
    remove_foreign_key(:projects, :name => 'projects_client_id_fk')
  end
end
