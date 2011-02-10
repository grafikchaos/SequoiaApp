When /^I follow "([^"]*)" to (.*) requiring confirmation$/ do |link, method|
  link = webrat.current_scope.find_link(link)
  link.click(:method => method)
end

Given /^I have no (.*)s$/ do |model|
  model.camelcase.constantize.delete_all
end

Then /^I should have (\d*) (.*)$/ do |count, model|
  model.singularize.camelcase.constantize.all.count == count.to_i
end
