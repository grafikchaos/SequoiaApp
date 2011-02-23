class Entity < ActiveRecord::Base
  belongs_to :project
  has_one :entity_type
  has_many :entity_rows
  has_one :note, :as => :notable
  
  # validations
  validates_presence_of :name, :project_id, :entity_type_id
  
  # accept Entity Row form fields/attributes
  accepts_nested_attributes_for :entity_rows, :reject_if => lambda { |row| row[:value].blank? }, :allow_destroy => true

  # friendly_id slug behavior
  has_friendly_id :name, 
                  :use_slug => true, 
                  :approximate_ascii => true,
                  :reserved_words => ['index', 'new', 'create', 'show', 'edit', 'update', 'delete', 'client', 'project', 'contact']
  
  # setting the default scope
  default_scope order(:project_id)

end
