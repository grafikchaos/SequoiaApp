class FormConfig < ActiveRecord::Base

  # relationships
  belongs_to :entity_type
  belongs_to :entity_rows

  attr_accessible :entity_type_id, :entity_key_id, :placeholder, :required, :sort_order

  # validations
  validates_presence_of :entity_key_id, :sort_order

  # default scope
  default_scope order(:sort_order)

  # named scopes
  scope :get_for_type, lambda { |id| 
    if id.nil?
      where(:entity_type_id => EntityType.first.id)
    else
      where(:entity_type_id => id)
    end
  }

end
