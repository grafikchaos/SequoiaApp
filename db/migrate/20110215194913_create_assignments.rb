class CreateAssignments < ActiveRecord::Migration
  def self.up
    create_table :assignments do |t|
      t.integer, :user_id, :role_id, :null => false
      t.timestamps
    end
    add_index :assignments, :role_id
    add_index :assignments, :user_id
    
    add_foreign_key(:assignments, :users, :dependent => :delete)
    add_foreign_key(:assignments, :roles, :dependent => :delete)
  end

  def self.down
    drop_table :assignments
  end
end
