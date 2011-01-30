class AddForeignKeysForEntityTables < ActiveRecord::Migration
  def self.up
    change_table :entities do |t|
      t.foreign_key :projects, :dependent => :delete
      t.foreign_key :entity_types
    end
    
    change_table :entity_rows do |t|
      t.foreign_key :entities, :dependent => :delete
      t.foreign_key :entity_keys
    end
  end

  def self.down
    remove_foreign_key(:entities, :name => 'entities_entity_type_id_fk')
    remove_foreign_key(:entities, :name => 'entities_project_id_fk')
    remove_foreign_key(:entity_rows, :name => 'entity_rows_entity_key_id_fk')
    remove_foreign_key(:entity_rows, :name => 'entity_rows_entity_id_fk')
  end
end