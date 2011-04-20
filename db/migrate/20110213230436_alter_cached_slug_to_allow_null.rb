class AlterCachedSlugToAllowNull < ActiveRecord::Migration
  def self.up
    change_column(:entity_types, :cached_slug, :string, :null => true)
    change_column(:entity_keys, :cached_slug, :string, :null => true)
  end

  def self.down
    change_column(:entity_types, :cached_slug, :string, :null => false)
    change_column(:entity_keys, :cached_slug, :string, :null => false)
  end
end
