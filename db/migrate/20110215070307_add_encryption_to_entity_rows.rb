class AddEncryptionToEntityRows < ActiveRecord::Migration
  def self.up
    add_column :entity_rows, :encrypt, :boolean, :after => :value, :default => false
  end

  def self.down
    remove_column :entity_rows, :encrypt
  end
end
