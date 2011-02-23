class EntityTypeAlias < ActiveRecord::Base
  belongs_to :entity_type

  validates_uniqueness_of :name
  validates_presence_of :name, :entity_type_id
  
  # friendly_id slug behavior
  has_friendly_id :name, 
                  :use_slug => true, 
                  :approximate_ascii => true,
                  :reserved_words => ['index', 'new', 'create', 'show', 'edit', 'update', 'delete', 'client', 'project', 'contact']
end
