class CreateEntityKeys < ActiveRecord::Migration
  def self.up
    create_table :entity_keys do |t|
      t.string :name, :cached_slug, :null => false
      t.timestamps
    end
    
    add_index :entity_keys, :id, :unique => true
    add_index :entity_keys, :name, :unique => true
    add_index :entity_keys, :cached_slug
    
  end

  def self.down
    drop_table :entity_keys
  end
end
