Given /^I have bookmarked clients (.*)$/ do |codes|
  codes.split(', ').each do |code|
    client = Client.find_by_client_code(code)
    Factory.create(:favorite, :favable_type => client.class.to_s, :favable_id => client.id, :note => client.name)
  end
end

