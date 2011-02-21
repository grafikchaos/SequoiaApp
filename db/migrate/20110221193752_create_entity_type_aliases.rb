class CreateEntityTypeAliases < ActiveRecord::Migration
  def self.up
    create_table :entity_type_aliases do |t|
      t.integer :entity_type_id, :null => false
      t.string :name, :null => false
      t.string :cached_slug, :null => true
      t.timestamps
    end
    add_foreign_key(:entity_type_aliases, :entity_types, :dependent => :delete)
  end

  def self.down
    drop_table :entity_type_aliases
  end
end
