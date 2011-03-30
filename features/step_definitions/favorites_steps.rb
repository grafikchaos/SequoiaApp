Given /^I have bookmarked clients (.*)$/ do |codes|
  codes.split(', ').each do |code|
    client = Client.find_by_client_code(code)
    Factory.create(:favorite, :favable_type => client.class.to_s, :favable_id => client.id, :note => client.name)
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

