class Project < ActiveRecord::Base
  
  belongs_to :client
  
  validates_presence_of :client_id, :name
  validates_uniqueness_of :name, :scope => [:client_id], :case_sensitive => false

  def self.filter(proj)
    
  end    
  
end
