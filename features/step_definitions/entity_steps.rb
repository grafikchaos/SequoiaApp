Given /^entity type "([^"]*)" exists$/ do |type|
  EntityType.create! :name => type, :cached_slug => type.downcase
end

Given /^the client (.*)'s project "([^"]*)" has an entity named "([^"]*)" with type "(.*)"$/ do |client, proj, entity, type|
  client = Client.find_by_client_code(client)
  project = Project.find_by_name_and_client_id(proj, client.id)
  entity_type = EntityType.find_by_name(type)
  Entity.create! :name => entity, :project_id => project.id, :entity_type_id => entity_type.id
end

Then /^the project "([^"]*)" for the client "(.*)" should have (\d+) entit/ do |proj, client, count|
  client = Client.find_by_client_code(client)
  project = Project.find_by_name_and_client_id(proj, client.id)
  project.entities.count == count.to_i
end

