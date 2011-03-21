class CreateFormConfigs < ActiveRecord::Migration
  def self.up
    create_table :form_configs do |t|
      t.integer :entity_type_id, :entity_key_id, :null => false
      t.string  :element_type, :placeholder
      t.boolean :required, :null => false, :default => 0
      t.column  :sort_order, 'integer unsigned', :null => false, :default => 0
      t.timestamps
    end

    add_foreign_key(:form_configs, :entity_types, :dependent => :delete)
    add_foreign_key(:form_configs, :entity_keys, :dependent => :delete)
  end

  def self.down
    drop_table :form_configs
  end
end
