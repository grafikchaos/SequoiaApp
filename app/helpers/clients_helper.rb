module ClientsHelper
  def page_title(client)
    client.name + ' (' + client.client_code + ')' 
  end

  def display_title(client)
    image_tag(client.logo.url(:medium)) +
    page_title(client)
  end
end
