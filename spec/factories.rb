Factory.define :user do |u|
  u.username 'user'
  u.password 'test1234'
  u.password_confirmation { |p| "#{p.password}" }
  u.role 'staff'
  u.sequence(:email) {|n| "person#{n}@example.com".downcase } # => person1@example.com
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

Factory.define :entity_type_alias do |aka|
  aka.name 'Some alias'
  aka.entity_type_id 1
end

Factory.define :entity_key do |key|
  key.name 'Username'
  key.mask 0
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

