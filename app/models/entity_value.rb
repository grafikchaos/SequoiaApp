class EntityValue < ActiveRecord::Base
  
  belongs_to :entity
  has_one :entity_attribute
  
end
