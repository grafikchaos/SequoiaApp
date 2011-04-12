class EntityType < ActiveRecord::Base
  has_many :entities
  has_many :entity_type_aliases
  has_many :form_configs
  
  # validations
  validates :name, :presence => true, :uniqueness => true, :length => (2..255)
  
  # Make sure the record is not already an alias of another record
  validates_each :name do |record, attr, value|
    a = EntityTypeAlias.find_by_name(value)
    if a
      record.errors.add value, "is already an alias of entity type #{a.entity_type.name}"
    end
  end
  
  attr_accessible :name, :entity_type_aliases_attributes, :form_configs_attributes

  # accept Entity Type Aliases and Config Rows form fields/attributes
  accepts_nested_attributes_for :entity_type_aliases, :reject_if => lambda { |row| row[:name].blank? }, :allow_destroy => true
  accepts_nested_attributes_for :form_configs, :reject_if => lambda { |row| row[:entity_key_id].blank? }, :allow_destroy => true

  # friendly_id slug behavior
  has_friendly_id :name, 
                  :use_slug => true, 
                  :approximate_ascii => true,
                  :reserved_words => ['index', 'new', 'create', 'show', 'edit', 'update', 'delete', 'client', 'project', 'contact']
  
  # versioning
  has_paper_trail :only => [:name]
  
  
  default_scope includes(:entity_type_aliases, :form_configs).order(:entity_types => :name)

  def to_s
    self.name
  end

end
