Given /^"([^"]*)" has bookmarked the (.*) "([^"]*)"$/ do |username, type, name|
  user = User.find_by_username(username)
  case type
    when "Client"
      obj = Client.find_by_client_code(name)
      Factory.create(:favorite, :favable_type => "Client", :favable_id => obj.id, :user_id => user.id, :note => obj.name)
  end
end

When /^I favorite the (\d+)\w{2} item in the list$/ do |number|
  within("#results-list div.row:nth-child(#{number})") do
    click_link "Favorite"
  end
end

When /^I favorite the query string$/ do
  within('#search-container') do
    click_link 'Favorite'
  end
end

Then /^"([^"]*)" should have (\d+) favorite$/ do |username, count|
  user = User.find_by_username(username)
  favs = Favorite.find_all_by_user_id(user.id)
  favs.count == count
end

