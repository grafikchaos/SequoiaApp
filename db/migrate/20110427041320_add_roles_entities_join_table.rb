class AddRolesEntitiesJoinTable < ActiveRecord::Migration
  def self.up
    create_table :entity_roles, :id => false do |t|
      t.integer :entity_id, :role_id
    end

    add_foreign_key(:entity_roles, :entities, :dependent => :delete)
    add_foreign_key(:entity_roles, :roles, :dependent => :delete)
  end

  def self.down
    drop_table :entity_roles
  end
end
