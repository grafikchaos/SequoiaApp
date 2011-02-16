Given /^the client "(.*)" does not have a project named "(.*)"$/ do |client, proj|
  client = Client.find_by_client_code(client)
  client.projects.each { |project| project.delete! if project.name == proj }
end

Given /^the client "([^"]*)" has a default project named "([^"]*)" with domain "([^"]*)"$/ do |client, name, domain|
  client = Client.find_by_client_code(client)
  Project.find_by_client_id_and_name(client.id, "Default").delete
  Factory.create(:project, :client_id => client.id, :name => name, :domain => domain)
end

Given /^the client "([^"]*)" has a project named "([^"]*)" with domain "([^"]*)"$/ do |client, name, domain|
  client = Client.find(client)
  Factory.create(:project, :client_id => client.id, :name => name, :domain => domain)
end

Given /^the client "([^"]*)" has (\d+) projects$/ do |client, count|
  client = Client.find_by_client_code(client)
  client.projects.count == count.to_i
end

When /^I follow "([^"]*)" to (.*) for the project "(.*)" requiring confirmation$/ do |link, method, project|
  link = webrat.current_scope.find_link(link)
  link.click(:method => method)
end

Then /^the client "([^"]*)" should have (\d+) project$/ do |client, count|
  client = Client.find_by_client_code(client)
  client.projects.count == count.to_i
end

Then /^the client "([^"]*)" should have a project named "([^"]*)"$/ do |client, proj|
  client = Client.find_by_client_code(client)
  client.projects.include?(proj)
end

Then /^the client "([^"]*)" should not have a project named "([^"]*)"$/ do |client, proj|
  client = Client.find_by_client_code(client)
  !client.projects.include?(proj)
end
