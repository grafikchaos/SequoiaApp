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

Factory.define :entity_key do |ek|
  ek.name 'Username'
end

Factory.define :entity do |e|
  e.name 'An Entity'
  e.project_id 1
  e.entity_type_id 1
  e.clearance 3
end

Factory.define :entity_row do |er|
  er.entity_id 1
  er.entity_key_id 1
  er.value 'value'
end
