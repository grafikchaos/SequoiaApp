Factory.define :user do |u|
  u.first_name            { Faker::Name.first_name }
  u.last_name             { Faker::Name.last_name }
  u.username              { Faker::Internet.user_name }
  u.password              'test1234'
  u.password_confirmation { |p| "#{p.password}" }
  u.sequence(:email)      {|n| "person#{n}@example.com".downcase } # => person1@example.com
end

Factory.define :role do |r|
  r.name 'staff'
end

Factory.define :user_role do |assign|
  assign.user_id 1
  assign.role_id 3
end

Factory.define :entity_role do |er|
  er.entity_id 1
  er.role_id 3
end


Factory.define :client do |c|
  c.name                    { Faker::Company.name }
  c.sequence(:client_code)  { |n| "ROR#{n}" } # => ROR1 
end

Factory.define :project do |p|
  p.name 'Default'
  p.domain { Faker::Internet.domain_name }
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
end

Factory.define :entity_row do |er|
  er.entity_id 1
  er.entity_key_id 1
  er.form_config_id nil
  er.value 'value'
end

Factory.define :favorite do |fav|
  fav.favable_type 'Client'
  fav.favable_id 1
  fav.note 'Some favorite'
  fav.name { |f| "#{f.note}" }
  fav.user_id 1
end
