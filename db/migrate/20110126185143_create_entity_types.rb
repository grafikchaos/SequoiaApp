class CreateEntityTypes < ActiveRecord::Migration
  def self.up
    create_table :entity_types do |t|
      t.string :name, :cached_slug, :null => false
      t.timestamps
    end

    add_index :entity_types, :id, :unique => true
    add_index :entity_types, :name, :unique => true
    add_index :entity_types, :cached_slug
    
  end

  def self.down
    drop_table :entity_types
  end
end
