class EntityRow < ActiveRecord::Base
  belongs_to :entity_key
  belongs_to :entity
  
end
