class AddCachedSlugToClients < ActiveRecord::Migration
  def self.up
      add_column :clients, :cached_slug, :string
      add_index  :clients, :cached_slug
    end

    def self.down
      remove_column :clients, :cached_slug
    end
end
