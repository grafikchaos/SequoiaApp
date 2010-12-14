class CreateClients < ActiveRecord::Migration
  def self.up
    create_table :clients do |t|
      t.primary_key :id
      t.string :name
      t.string :client_code

      t.timestamps
    end
  end

  def self.down
    drop_table :clients
  end
end
