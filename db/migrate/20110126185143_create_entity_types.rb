class CreateEntityTypes < ActiveRecord::Migration
  def self.up
    create_table :entity_types do |t|
      t.string :name, :cached_slug, :null => false
      t.timestamps
    end

    add_index :entity_types, :id
    add_index :entity_types, :name
    add_index :entity_types, :cached_slug
    
  end

  def self.down
    drop_table :entity_types
  end
end
