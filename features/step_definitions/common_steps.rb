Given /^the following (.+) records?$/ do |factory, table|
  # table is a Cucumber::Ast::Table
  case factory
  when 'entity_type_alias'
    table.hashes.each do |row|
      type = EntityType.find_by_name(row['type'])
      row['aliases'].split(', ').each do |aka|
        Factory.create(:entity_type_alias, :entity_type_id => type.id, :name => aka)
      end
    end
  else
    table.hashes.each do |hash|
      Factory.create(factory, hash)
    end
  end
end

Given /^I have no (.*)s$/ do |model|
  model.camelcase.constantize.delete_all
end

When /^I follow "([^"]*)" to (.*) requiring confirmation$/ do |link, method|
  link = webrat.current_scope.find_link(link)
  link.click(:method => method)
end

Then /^I should have (\d*) (.*)$/ do |count, model|
  model.singularize.camelcase.constantize.all.count == count.to_i
end

Then /^I should see the following (.*)$/ do |model, expected|
  expected.diff!(tableish("table#" + model + " tr", "td").to_a)
end
