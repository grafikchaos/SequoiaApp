class Project < ActiveRecord::Base
  
  belongs_to :client

  def self.filter(proj)
    
  end    
  
end
