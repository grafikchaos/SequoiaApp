class Entity < ActiveRecord::Base
  belongs_to :project
  has_one :entity_type
  
  has_many :entity_rows
  
  # validations
  validates_presence_of :name
  validates_presence_of :project_id
  validates_presence_of :entity_type_id
  
  # accept Entity Row form fields/attributes
  accepts_nested_attributes_for :entity_rows, :reject_if => lambda { |row| row[:name].blank? }, :allow_destroy => true

  # friendly_id slug behavior
  has_friendly_id :name, 
                  :use_slug => true, 
                  :approximate_ascii => true,
                  :reserved_words => ['index', 'new', 'create', 'show', 'edit', 'update', 'delete', 'client', 'project', 'contact']
  
end
