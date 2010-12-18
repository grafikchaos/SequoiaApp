class Client < ActiveRecord::Base
  
  has_many :projects
  
  validates_presence_of :name
  validates_presence_of :client_code
  
  def self.search(term)
    if term
      where('name LIKE ? OR client_code LIKE ?', "%#{term}%", "%#{term}%")
    else
      find(:all)
    end
  end
  
end
