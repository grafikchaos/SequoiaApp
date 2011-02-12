Given /^a user "([^"]*)" exists$/ do |username|
  unless User.find_by_username(username)
    User.new(
      :username => username,
      :email => 'user@example.com',
      :password => 'test1234',
      :password_confirmation => 'test1234'
    ).save!
  end
end

