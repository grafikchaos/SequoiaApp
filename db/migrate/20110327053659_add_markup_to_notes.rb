class AddMarkupToNotes < ActiveRecord::Migration
  def self.up
    add_column :notes, :markup, :string, :after => :content, :null => false
  end

  def self.down
    remove_column :notes, :markup
  end
end
