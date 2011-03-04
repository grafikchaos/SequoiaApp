class EntityTypeConfigRow < ActiveRecord::Base
  belongs_to :entity_type

  validates_presence_of :entity_type_id, :entity_key_id, :sort_order

  # setting the default scope
  default_scope order(:sort_order)
end
