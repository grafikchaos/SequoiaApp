class QueryString < ActiveRecord::Base
  
  # For bookmarking
  acts_as_favable

  validates_presence_of :name

end
