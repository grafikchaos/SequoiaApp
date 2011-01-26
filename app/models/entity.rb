class Entity < ActiveRecord::Base
  belongs_to :project
  belongs_to :entity_type
  
  has_many :entity_rows
end
