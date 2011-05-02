Given /^the following (.+) records?$/ do |factory, table|
  # table is a Cucumber::Ast::Table
  case factory
    when 'user'
      table.hashes.each do |row|
        user = User.find_by_username(row['username'])
        row['roles'].split(', ').each do |aka|
          Factory.create(:entity_type_alias, :entity_type_id => type.id, :name => aka)
        end
      end
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

Given /^I have no (.*)$/ do |model|
  model.pluralize.singularize.camelcase.constantize.delete_all
end

When /^I delete the (\d+)\w{2} Entity Row$/ do |number|
  # This will fail if we move the password generator link
  within("#entity_rows_form .fieldset-wrapper .entity-row-field:nth-child(#{number.to_i + 1})") do
    click_link('Delete')
  end
end

When /^I undelete the (\d+)\w{2} Entity Row$/ do |number|
  # This will fail if we move the password generator link
  within("#entity_rows_form .fieldset-wrapper .entity-row-field:nth-child(#{number.to_i + 1})") do
    click_link('Undo?')
  end
end

Then /^I should have (\d*) (.*)$/ do |count, model|
  model.pluralize.singularize.camelcase.constantize.all.count == count.to_i
end

Then /^I should see the following (.*)$/ do |model, expected|
  html_table = tableish('table#' + model + ' tr', 'td,th')
  html_table.map! { |r| r.map! { |c| c.gsub(/<.+?>/, '') } } # strip HTML from all cells
  html_table.map! { |r| r.map! { |c| c.gsub(/[\r\n\t\s]+/, ' ') } } # strip line breaks and multiple spaces
  expected.diff!(html_table)
end