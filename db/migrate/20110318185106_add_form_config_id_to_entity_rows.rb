class AddFormConfigIdToEntityRows < ActiveRecord::Migration
  def self.up
    add_column :entity_rows, :form_config_id, :integer, :after => :entity_id, :null => true, :default => nil
  end

  def self.down
    remove_column :entity_rows, :form_config_id
  end
end
