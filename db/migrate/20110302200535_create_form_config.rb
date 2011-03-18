class CreateEntityTypeConfigRows < ActiveRecord::Migration
  def self.up
    create_table :form_config do |t|
      t.integer :entity_type_id, :null => false
      t.integer :entity_key_id, :null => false
      t.string :element_type
      t.string :placeholder
      t.boolean :required, :null => false, :default => 0
      t.column :sort_order, 'integer unsigned', :null => false, :default => 0
      t.timestamps
    end

    add_foreign_key(:form_config, :entity_types, :dependent => :delete)
    add_foreign_key(:form_config, :entity_keys, :dependent => :delete)
  end

  def self.down
    drop_table :form_config
  end
end
