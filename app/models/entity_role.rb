class EntityRole < ActiveRecord::Base
  belongs_to :entity
  belongs_to :role
end