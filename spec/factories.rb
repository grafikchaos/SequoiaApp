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

Factory.define :entity_key do |key|
  key.name 'Key Name'
end
