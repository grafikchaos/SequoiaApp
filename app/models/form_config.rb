class FormConfig < ActiveRecord::Base
  belongs_to :entity_type

  attr_accessible :entity_type_id, :entity_key_id, :placeholder, :required, :sort_order

  validates_presence_of :entity_key_id, :sort_order

  # setting the default scope
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
