class CreateWelcomeMessages < ActiveRecord::Migration
  def self.up
    create_table :welcome_messages do |t|
      t.string :message
      t.timestamps
    end
  end

  def self.down
    drop_table :welcome_messages
  end
end
