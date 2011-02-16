Given /^the following Entity Rows exist$/ do |table|
  table.hashes.each do |row|
    client = Client.find(row['client'])
    project = Project.find_by_name_and_client_id(row['project'], client.id)
    entity = Entity.find_by_name_and_project_id(row['entity'], project.id)
    key = EntityKey.find(row['key'])
    Factory.create(:entity_row, :entity_id => entity.id, :entity_key_id => key.id, :value => row['value'])
  end
end
