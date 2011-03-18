class EntityRow < ActiveRecord::Base
  belongs_to :entity_key
  belongs_to :entity
  has_one :form_config
  
  attr_encrypted :value, :key => Ashint::Application.config.encryption_key, :encode => true
  attr_accessible :value, :encrypted_value, :entity_key_id, :form_config_id
end
