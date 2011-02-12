Given /^I have no (.*)s$/ do |model|
  model.camelcase.constantize.delete_all
end

Given /^I am logged in as a user$/ do
  Factory.create(:user)
  visit new_user_session_path
  fill_in("Username", :with => 'user' )
  fill_in("Password", :with => 'test1234' )
  click_button("Sign in")
end

When /^I follow "([^"]*)" to (.*) requiring confirmation$/ do |link, method|
  link = webrat.current_scope.find_link(link)
  link.click(:method => method)
end

Then /^I should have (\d*) (.*)$/ do |count, model|
  model.singularize.camelcase.constantize.all.count == count.to_i
end