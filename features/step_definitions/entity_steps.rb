Given /^entity type "([^"]*)" exists$/ do |type|
  EntityType.new(:name => type).save!
end

Then /^the project "([^"]*)" for the client "(.*)" should have (\d+) entit/ do |proj, client, count|
  client = Client.find_by_client_code(client)
  project = Project.find_by_name_and_client_id(proj, client.id)
  project.entities.count == count.to_i
end

