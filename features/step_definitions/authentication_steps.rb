Given /^a user "([^"]*)" exists$/ do |username|
  unless User.find_by_username(username)
    Factory.create(:user, :username => username)
  end
end

When /^I mess up logging in as "([^"]*)" (\d+) times$/ do |username, count|
  10.times do
    visit new_user_session_path
    fill_in "user[username]", :with => username
    fill_in "user[password]", :with => 'notmypassword'
    click_button "Sign in"
  end
end

