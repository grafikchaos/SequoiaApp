class CreateQueryStrings < ActiveRecord::Migration
  def self.up
    create_table :query_strings do |t|
      t.string :string
      t.timestamps
    end

    add_index :query_strings, :string
  end

  def self.down
    drop_table :query_strings
  end
end
