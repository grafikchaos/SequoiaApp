class EntityType < ActiveRecord::Base
  belongs_to :entities
  has_many :entity_type_aliases
  
  # validations
  validates_presence_of :name
  validates_uniqueness_of :name
  
  attr_accessible :name

  # accept Entity Type Aliases form fields/attributes
  accepts_nested_attributes_for :entity_type_aliases, :reject_if => lambda { |row| row[:name].blank? }, :allow_destroy => true

  # friendly_id slug behavior
  has_friendly_id :name, 
                  :use_slug => true, 
                  :approximate_ascii => true,
                  :reserved_words => ['index', 'new', 'create', 'show', 'edit', 'update', 'delete', 'client', 'project', 'contact']
  
  default_scope order(:name)

end
