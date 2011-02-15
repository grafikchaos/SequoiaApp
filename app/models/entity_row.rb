class EntityRow < ActiveRecord::Base
  belongs_to :entity_key
  belongs_to :entity
  
  before_save :encrypt_value

  def decrypt_value
    require "base64"
    self.value = Base64.decode64(self.value)
  end

  # Private methods below here!

  private

  def encrypt?
    return self.encrypt
  end

  def encrypt_value
    if self.encrypt
      require "base64"
      self.value = Base64.encode64(self.value)
    end
  end
end
