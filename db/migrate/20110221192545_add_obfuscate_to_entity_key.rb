class AddObfuscateToEntityKey < ActiveRecord::Migration
  def self.up
    add_column :entity_keys, :obfuscate, :boolean, :default => false, :after => :cached_slug
  end

  def self.down
    remove_column :entity_keys, :obfuscate
  end
end
