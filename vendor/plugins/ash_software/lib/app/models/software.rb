class Software < ActiveRecord::Base
  
  belongs_to :software_type
  has_many :software_versions
  
end
