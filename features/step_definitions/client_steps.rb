Given /^I have client codes (.+)$/ do |client_codes|
  client_codes.split(', ').each do |client_code|
    Client.create!(:client_code => client_code, :name => client_code + " Company Name Here")
  end
end
 
When /^I search for "([^"]*)"$/ do |query|
  Client.search(query)
end