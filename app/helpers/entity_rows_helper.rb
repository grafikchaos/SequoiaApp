module EntityRowsHelper

  def decode_password(row)
    if row.entity_key.name.downcase == 'password'
      require "base64"
      password = Base64.decode64(row.value)
    end
    password || row.value
  end

end
