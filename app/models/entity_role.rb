class EntityRole < ActiveRecord::Base

  # relationships
  belongs_to :entity
  belongs_to :role

end
