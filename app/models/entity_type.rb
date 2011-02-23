class EntityType < ActiveRecord::Base
  belongs_to :entities
  has_many :entity_type_aliases
  
  # validations
  validates_presence_of :name
  validates_uniqueness_of :name
  # Make sure the record is not already an alias of another record
  validates_each :name do |record, attr, value|
    a = EntityTypeAlias.find_by_name(value)
    if a
      record.errors.add value, "is already an alias of entity type #{a.entity_type.name}"
    end
  end
  
  attr_accessible :name, :entity_type_aliases_attributes

  # accept Entity Type Aliases form fields/attributes
  accepts_nested_attributes_for :entity_type_aliases, :reject_if => lambda { |row| row[:name].blank? }, :allow_destroy => true

  # friendly_id slug behavior
  has_friendly_id :name, 
                  :use_slug => true, 
                  :approximate_ascii => true,
                  :reserved_words => ['index', 'new', 'create', 'show', 'edit', 'update', 'delete', 'client', 'project', 'contact']
  
  default_scope order(:name)

end
