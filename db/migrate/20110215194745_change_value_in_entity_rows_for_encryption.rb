class ChangeValueInEntityRowsForEncryption < ActiveRecord::Migration
  def self.up
    rename_column :entity_rows, :value, :encrypted_value
  end

  def self.down
    rename_column :entity_rows, :encrypted_value, :value
  end
end
