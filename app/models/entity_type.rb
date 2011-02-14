class EntityType < ActiveRecord::Base
  belongs_to :entities
  
  # validations
  validates_presence_of :name
  validates_uniqueness_of :name
  
  attr_accessible :name

  # friendly_id slug behavior
  has_friendly_id :name, 
                  :use_slug => true, 
                  :approximate_ascii => true,
                  :reserved_words => ['index', 'new', 'create', 'show', 'edit', 'update', 'delete', 'client', 'project', 'contact']
  
  default_scope order(:name)

end
