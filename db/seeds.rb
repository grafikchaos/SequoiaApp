# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

clients = Client.create([
  { :name => 'August Ash, Inc.', :client_code => 'AAI' }
])

entity_types = EntityType.create([
  { :name => 'MySQL' },
  { :name => 'SSH' }
])

entity_attributes = EntityAttribute.create([
  { :name => 'Username' },
  { :name => 'Password' },
  { :name => 'Host' },
  { :name => 'Database Name' },
  { :name => 'URL' }
])
