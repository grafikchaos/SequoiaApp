class EntityRow < ActiveRecord::Base
  belongs_to :entity_keys
  belongs_to :entity
  
end
