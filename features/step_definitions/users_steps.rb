Given /^I am logged in as a user$/ do
  Factory.create(:user)
  visit new_user_session_path
  fill_in("Username", :with => 'user' )
  fill_in("Password", :with => 'test1234' )
  click_button("Sign in")
end

Given /^I am logged in as a user with Level (\d+) clearance$/ do |clearance|
  Factory.create(:user, :clearance => clearance)
  visit new_user_session_path
  fill_in("Username", :with => 'user' )
  fill_in("Password", :with => 'test1234' )
  click_button("Sign in")
end

Given /^I am logged in as "([^"]*)" with password "([^"]*)"$/ do |username, password|
  visit new_user_session_path
  fill_in "Username", :with => username
  fill_in "Password", :with => password
  click_button "Sign in"
end