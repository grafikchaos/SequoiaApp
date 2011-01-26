class CreateEntities < ActiveRecord::Migration
  def self.up
    create_table :entities do |t|
      t.integer :project_id, :entity_type_id, :null => false
      t.string :name, :cached_slug, :null => false
      t.timestamps
    end
    
    add_index :entities, :id
    add_index :entities, :project_id
    add_index :entities, :entity_type_id
    add_index :entities, :name
    add_index :entities, :cached_slug
    
  end

  def self.down
    drop_table :entities
  end
end
