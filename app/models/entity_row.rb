class EntityRow < ActiveRecord::Base
  belongs_to :entity_key
  belongs_to :entity
  
  before_save :encrypt_password

  # Private methods below here!

  private

  def encrypt_password
    ek = EntityKey.find(self.entity_key_id)
    if ek.name.downcase == 'password'
      require "base64"
      encoded = Base64.encode64(self.value)
      self.value = encoded
    end
  end
end
