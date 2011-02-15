class AddEncryptionToEntityKeys < ActiveRecord::Migration
  def self.up
    add_column :entity_keys, :encrypt, :boolean, :after => :name, :default => false
  end

  def self.down
    remove_column :entity_keys, :encrypt
  end
end
