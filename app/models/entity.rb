class Entity < ActiveRecord::Base
  
  belongs_to :project
  has_eav_behavior
  
end
