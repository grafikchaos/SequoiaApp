Given /^entity type "([^"]*)" exists$/ do |type|
  EntityType.create! :name => type, :cached_slug => type.downcase
end

Given /^the following Entities exist$/ do |table|
  table.hashes.each do |row|
    client      = Client.find(row['client'])
    project     = Project.find_by_name_and_client_id(row['project'], client.id)
    entity_type = EntityType.find_by_name(row['type'])
    entity      = Factory.create(:entity, :name => row['name'], :project_id => project.id, :entity_type_id => entity_type.id)
    
    unless row['roles'].nil?
      row['roles'].split(', ').each do |role_name|
        role = Role.find_or_create_by_name(role_name)
        Factory.create(:entity_role, :entity_id => entity.id, :role_id => role.id)
      end
    end
  end
end

Then /^"([^\"]*)" should have (\d+) "([^\"]*)"$/ do |selector1, count, selector2|
  within(selector1) do |content|
    content.should have_selector(selector2, :count => count.to_i)
  end
end

Then /^the project "([^"]*)" for the client "(.*)" should have (\d+) entit/ do |proj, client, count|
  client = Client.find(client)
  project = Project.find_by_name_and_client_id(proj, client.id)
  project.entities.count == count.to_i
end

Then /^I should only see (\d+) delete link[s]?$/ do |count|
  page.should have_css('.destroy-link', :count => count.to_i)
end

