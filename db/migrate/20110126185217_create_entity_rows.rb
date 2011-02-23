class CreateEntityRows < ActiveRecord::Migration
  def self.up
    create_table :entity_rows do |t|
      t.integer :entity_id, :entity_key_id, :null => false
      t.string :value, :null => false

      t.timestamps
    end

    add_index :entity_rows, :id, :unique => true
    add_index :entity_rows, :entity_id
    add_index :entity_rows, :entity_key_id
    add_index :entity_rows, :value

  end

  def self.down
    drop_table :entity_rows
  end
end
