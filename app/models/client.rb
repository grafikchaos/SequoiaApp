class Client < ActiveRecord::Base
  # paperclip behavior
  has_attached_file :logo, :styles => { :mini => "24x24>", :small => "64x64>", :medium => "96x96>", :big => "200x200>" }

  has_many :projects
  
  # validates_presence_of   :name
  validates_presence_of :name, :on => :create, :message => "client name can't be blank"
  
  validates_presence_of   :client_code
  validates_uniqueness_of :client_code, :case_sensitive => false
  validates_length_of     :client_code, :within => 2..10
  
  before_save :capitalize_client_code
  
  # columns open to mass-assignment
  attr_accessible :name, :client_code, :logo, :logo_file_name, :logo_content_type, :logo_size, :logo_updated_at

  # friendly_id slug behavior
  # has_friendly_id :client_code, 
  #                 :use_slug => true, 
  #                 :approximate_ascii => true,
  #                 :reserved_words => ['index', 'new', 'create', 'show', 'edit', 'update', 'delete', 'client', 'project', 'contact']
                  
  #------------
  # named scopes 
  #   allows chaining of scopes together
  #   essentially linking statements together with 'AND'
  #------------
  scope :client_name_like, lambda { |name| where('clients.name LIKE ?', "%#{name}%") }
  scope :client_code_like, lambda { |code| where('clients.client_code LIKE ?', "%#{code}%") }
  scope :project_domain_like, lambda { |domain| where('projects.domain LIKE ?', "%#{domain}%") }
  scope :simple_search, lambda { |query| includes(:projects).where('clients.name LIKE ? OR clients.client_code LIKE ? OR projects.domain LIKE ?', "%#{query}%", "%#{query}%", "%#{query}%") }
  scope :ordered_by_client_code, order('clients.client_code ASC')
  
  #------------
  # search by client's name, client code or project domain name 
  # or return nil if no search term provided
  #------------
  def self.search(term)
    @results = (term) ? self.simple_search(term).ordered_by_client_code : nil
  end

  ##############################
  # PROTECTED METHODS BELOW HERE
  ##############################
  protected

  def capitalize_client_code
     self.client_code.upcase! if self.client_code
  end
  
end
