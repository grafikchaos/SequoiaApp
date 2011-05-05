Then /^"([^"]*)" should have the "([^"]*)" role$/ do |username, role|
  user = User.find_by_username(username)
  user.has_role?(role)
end

Then /^"([^"]*)" should not have the "([^"]*)" role$/ do |username, role|
  user = User.find_by_username(username)
  user.has_role?(role)
end
