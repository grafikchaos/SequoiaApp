class Role < ActiveRecord::Base
  has_many :users, :through => :assignments
  
  # define which columns are mass assignable
  attr_accessible :name

  # validations
  validates :name, :presence => true, :length => (2..255), :uniqueness => true
  
  # versioning
  has_paper_trail :only => [:name]
  
end
