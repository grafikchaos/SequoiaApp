class AddFormConfigIdToEntityRows < ActiveRecord::Migration
  def self.up
    add_column :entity_rows, :form_config_id, :integer
  end

  def self.down
    remove_column :entity_rows, :form_config_id
  end
end
