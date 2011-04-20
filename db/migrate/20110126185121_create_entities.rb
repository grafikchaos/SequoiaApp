class CreateEntities < ActiveRecord::Migration
  def self.up
    create_table :entities do |t|
      t.integer :project_id, :entity_type_id, :null => false
      t.string :name, :null => false
      t.timestamps
    end
    
    add_index :entities, :id
    add_index :entities, :project_id
    add_index :entities, :entity_type_id
    add_index :entities, :name
    
  end

  def self.down
    drop_table :entities
  end
end
