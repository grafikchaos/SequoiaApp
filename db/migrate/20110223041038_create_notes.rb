class CreateNotes < ActiveRecord::Migration
  def self.up
    create_table :notes do |t|
      t.integer :notable_id, :null => false
      t.string :notable_type, :null => false
      t.text :content, :null => false
      t.timestamps
    end
    add_index :notes, :notable_id
    add_index :notes, :notable_type
  end

  def self.down
    drop_table :notes
  end
end
