class Client < ActiveRecord::Base
  
  has_many :projects
  
  validates_presence_of :name, :client_code
  validates_uniqueness_of :client_code
  validates_length_of :client_code, :within => 2..10
  
  def self.search(term)
    if term
      joins(:projects).where('clients.name LIKE ? OR clients.client_code LIKE ? OR projects.domain LIKE ?', "%#{term}%", "%#{term}%", "%#{term}%")
    else
      all
    end
  end
  
end
