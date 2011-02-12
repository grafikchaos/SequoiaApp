Given /^a user "([^"]*)" exists$/ do |username|
  unless User.find_by_username(username)
    Factory.create(:user, :username => username)
  end
end

