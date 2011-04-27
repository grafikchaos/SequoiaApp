class Role < ActiveRecord::Base
  has_and_belongs_to_many :users, :join_table => :user_roles
  
  # define which columns are mass assignable
  attr_accessible :name

  # validations
  validates :name, :presence => true, :length => (2..255), :uniqueness => true
  
  # versioning
  has_paper_trail :only => [:name]
  
  # for audit log entries
  def to_s
    self.name
  end
  
end
