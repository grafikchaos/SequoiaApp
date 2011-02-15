module EntityRowsHelper

  def decode_password(row)
    if row.entity_key.name.downcase == 'password'
      require "base64"
      Base64.decode64(row.value)
    end
  end

end
