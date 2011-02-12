Given /^client "(.*)" exists$/ do |code|
  Factory.create(:client, :client_code => code)
end

Given /^the client "(.*)" does not have a project named "(.*)"$/ do |client, proj|
  client = Client.find_by_client_code(client)
  client.projects.each { |project| project.delete! if project.name == proj }
end

Then /^the client "([^"]*)" should have a project named "([^"]*)"$/ do |client, proj|
  client = Client.find_by_client_code(client)
  client.projects.include?(proj)
end

Then /^the client "([^"]*)" should not have a project named "([^"]*)"$/ do |client, proj|
  client = Client.find_by_client_code(client)
  !client.projects.include?(proj)
end
