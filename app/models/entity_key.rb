class EntityKey < ActiveRecord::Base

  # relationships
  has_many :entity_rows
  
  # validation
  validates_uniqueness_of :name, :case_sensitive => false
  validates               :name, :presence => true, :length => (2..255)

  # define which columns are mass-assignable
  attr_accessible :name, :mask
  
  
  # friendly_id slug behavior
  has_friendly_id :name, 
                  :use_slug => true, 
                  :approximate_ascii => true,
                  :reserved_words => ['index', 'new', 'create', 'show', 'edit', 'update', 'delete', 'client', 'project', 'contact']
                  
  # versioning
  has_paper_trail :only => [:name, :mask]

  def to_s
    self.name
  end
  
end
