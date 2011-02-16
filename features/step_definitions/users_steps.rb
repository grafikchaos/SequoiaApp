Given /^I am logged in as "([^"]*)" with password "([^"]*)"$/ do |username, password|
  visit new_user_session_path
  fill_in "Username", :with => username
  fill_in "Password", :with => password
  click_button "Sign in"
end

