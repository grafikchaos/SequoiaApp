class Entity < ActiveRecord::Base
  belongs_to :project
  belongs_to :entity_type
  
  has_many :entity_rows
  
  # validations
  validates_presence_of :name
  validates_presence_of :project_id
  validates_presence_of :entity_type_id
  
  # friendly_id slug behavior
  has_friendly_id :name, 
                  :use_slug => true, 
                  :approximate_ascii => true,
                  :reserved_words => ['index', 'new', 'create', 'show', 'edit', 'update', 'delete', 'client', 'project', 'contact']
  
end
