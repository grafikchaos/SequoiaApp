Given /^the following Entity Types are allowed$/ do |table|
  # table is a Cucumber::Ast::Table
  table.hashes.each do |et|
    Factory.create(:entity_type, et)
  end
end

Given /^the following Entity Keys exist$/ do |table|
  # table is a Cucumber::Ast::Table
  @entity_keys_list = table.raw.flatten.map {|key| EntityKey.new(key) }
end

Then /^"([^\"]*)" should have (\d+) "([^\"]*)"$/ do |selector1, count, selector2|
  within(selector1) do |content|
    content.should have_selector(selector2, :count => count.to_i)
  end
end

Given /^entity type "([^"]*)" exists$/ do |type|
  EntityType.create! :name => type, :cached_slug => type.downcase
end

Given /^the client "([^"]*)"'s project "([^"]*)" has an entity named "([^"]*)" with type "(.*)"$/ do |code, proj, entity, type|
  client = Client.find(code)
  project = Project.find_by_name_and_client_id(proj, client.id)
  entity_type = EntityType.find_by_name(type)
  Entity.create! :name => entity, :project_id => project.id, :entity_type_id => entity_type.id
end

Then /^the project "([^"]*)" for the client "(.*)" should have (\d+) entit/ do |proj, client, count|
  client = Client.find(client)
  project = Project.find_by_name_and_client_id(proj, client.id)
  project.entities.count == count.to_i
end

