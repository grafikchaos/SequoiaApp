Given /^I have client codes (.+)$/ do |client_codes|
  client_codes.split(', ').each do |client_code|
    Factory.create(:client, :client_code => client_code, :name => client_code + " Company Name Here")
  end
end
