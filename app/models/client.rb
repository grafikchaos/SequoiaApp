class Client < ActiveRecord::Base
  
  has_many :projects
  
  validates_presence_of :name, :client_code
  validates_uniqueness_of :client_code, :case_sensitive => false
  validates_length_of :client_code, :within => 2..10
  
  before_save :capitalize_client_code
  
  def self.search(term)
    if term
      # TODO: This looks terrible! Make this nicer.
      joins('LEFT JOIN projects ON projects.client_id = clients.id').where('clients.name LIKE ? OR clients.client_code LIKE ? OR projects.domain LIKE ?', "%#{term}%", "%#{term}%", "%#{term}%")
    else
      all
    end
  end
  
  protected
  
  def capitalize_client_code
     self.client_code.upcase! if self.client_code
  end
  
end
