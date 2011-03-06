class EntityTypeConfigRow < ActiveRecord::Base
  belongs_to :entity_type

  attr_accessible :entity_type_id, :entity_key_id, :placeholder, :required, :sort_order

  validates_presence_of :entity_key_id, :sort_order

  # setting the default scope
  default_scope order(:sort_order)
end
