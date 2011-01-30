class Project < ActiveRecord::Base
  has_many    :entities
  belongs_to  :client
  
  validates_presence_of :client_id
  validates_presence_of :name
  validates_uniqueness_of :name, :scope => [:client_id], :case_sensitive => false

  attr_accessible :name, :client_id, :domain

  def self.filter(proj)
    
  end    
  
end
