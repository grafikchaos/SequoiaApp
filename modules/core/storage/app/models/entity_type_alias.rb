class EntityTypeAlias < ActiveRecord::Base
  belongs_to :entity_type

  validates_uniqueness_of :name
  validates_presence_of :name
  # Make sure the record is not already an entity type
  validates_each :name do |record, attr, value|
    a = EntityType.find_by_name(value)
    if a
      record.errors.add value, "is already an entity type" 
    end
  end
  
  # friendly_id slug behavior
  has_friendly_id :name, 
                  :use_slug => true, 
                  :approximate_ascii => true,
                  :reserved_words => ['index', 'new', 'create', 'show', 'edit', 'update', 'delete', 'client', 'project', 'contact']

  attr_accessible :name, :entity_type_id
end
