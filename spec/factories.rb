Factory.define :user do |u|
  u.username 'user'
  u.email 'user@example.com'
  u.password 'test1234'
  u.password_confirmation 'test1234'
end

Factory.define :client do |c|
  c.name 'Ruby on Rails'
  c.client_code 'ROR'
end
