class Client < ActiveRecord::Base
  
  has_many :projects
  
  validates_presence_of :name, :client_code
  validates_uniqueness_of :client_code
  validates_length_of :client_code, :within => 2..10
  
  def self.search(term)
    if term
      where('name LIKE ? OR client_code LIKE ?', "%#{term}%", "%#{term}%")
    else
      all
    end
  end
  
end
