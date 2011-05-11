class EntityRow < ActiveRecord::Base

  # relationships
  belongs_to :entity_key
  belongs_to :entity
  has_one :form_config
  
  # encrypt the :value attribute
  attr_encrypted :value, :key => SequoiaApp::Application.config.encryption_key, :encode => true

  attr_accessible :value, :encrypted_value, :entity_key_id, :form_config_id

  # validations
  validates_presence_of :value, :if => :value_required?, :message => "is required"

  # versioning
  has_paper_trail :only => [:entity_id, :entity_key_id, :value, :encrypted_value]

  # default scope
  default_scope includes(:entity_key)

  def to_s
    self.name
  end

  ##############################
  # Private methods below here.
  ##############################
  private
  
  # Don't require a value if the :form_config_id is blank
  def value_required?
    self.form_config_id.blank? ? false : FormConfig.find(self.form_config_id).required
  end

end
