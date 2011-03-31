class CreateAudits < ActiveRecord::Migration
  def self.up
    create_table :audits do |t|
      t.primary_key :id
      t.integer :user_id
      t.text :message, :null => false
      t.string :controller_info
      t.integer :model_id
      t.string :model_type
      t.integer :version_id

      t.timestamps
    end
    add_foreign_key(:audits, :users, :dependent => :nullify)
    add_foreign_key(:audits, :versions, :dependent => :nullify)
  end

  def self.down
    drop_table :audits
  end
end
