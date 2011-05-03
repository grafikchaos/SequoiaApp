class Role < ActiveRecord::Base
  # has_and_belongs_to_many :users, :join_table => :user_roles
  # has_and_belongs_to_many :entities, :join_table => :entity_roles
  has_many :user_roles
  has_many :users, :through => :user_roles
  has_many :entity_roles
  has_many :entities, :through => :entity_roles
  
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
