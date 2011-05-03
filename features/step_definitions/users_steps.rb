Given /^I am logged in as a user$/ do
  user = Factory.create(:user)
  role = Factory.create(:role)
  Factory.create(:user_role, :user_id => user.id, :role_id => role.id)

  visit(new_user_session_path)
  fill_in("user[username]", :with => user.username )
  fill_in("user[password]", :with => 'test1234' )
  click_button("Sign in")
end

Given /^I am logged in as a user with Level (\d+) clearance$/ do |clearance|
  Factory.create(:user, :clearance => clearance)
  visit new_user_session_path
  fill_in("user_username", :with => 'user' )
  fill_in("user_password", :with => 'test1234' )
  click_button("Sign in")
end

Given /^I am logged in as "([^"]*)" with password "([^"]*)"$/ do |username, password|
  visit new_user_session_path
  fill_in "user_username", :with => username
  fill_in "user_password", :with => password
  click_button "Sign in"
end

Given /^the user "([^"]*)" is locked$/ do |username|
  user = User.find_by_username(username)
  user.locked_at = DateTime::now
  user.failed_attempts = 10
  user.unlock_token = 'wrfihwoihnwouh4o88h0'
  user.save
end
