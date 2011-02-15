Factory.define :user do |u|
  u.username 'user'
  u.email 'user@example.com'
  u.password 'test1234'
  u.password_confirmation 'test1234'
  u.clearance 3
end

Factory.define :client do |c|
  c.name 'Ruby on Rails'
  c.client_code 'ROR'
end

Factory.define :project do |p|
  p.name 'Default'
  p.domain 'example.com'
  p.client_id 1
end

Factory.define :entity_type do |et|
  et.name 'Some Entity Type'
end
