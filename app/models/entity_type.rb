class EntityType < ActiveRecord::Base
  has_many :entities
  
  # validations
  validates_presence_of :name
  
  # friendly_id slug behavior
  has_friendly_id :name, 
                  :use_slug => true, 
                  :approximate_ascii => true,
                  :reserved_words => ['index', 'new', 'create', 'show', 'edit', 'update', 'delete', 'client', 'project', 'contact']
  
end
