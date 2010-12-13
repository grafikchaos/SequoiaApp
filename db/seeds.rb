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
  { :name => 'Database' },
  { :name => 'SSH' },
  { :name => 'Website' },
  { :name => 'API' },
  { :name => 'FTP' }
])

entity_attributes = EntityAttribute.create([
  { :name => 'Username' },
  { :name => 'Password' },
  { :name => 'Host' },
  { :name => 'Database Name' },
  { :name => 'URL' },
  { :name => 'Token' },
  { :name => 'API Key' }
])

users = User.create([
  { :username => 'jbell', :email => 'jake@augustash.com', :hashed_password => 'TEST', :first_name => 'Jake', :last_name => 'Bell' },
  { :username => 'jjohnson', :email => 'jjohnson@augustash.com', :hashed_password => 'TEST' }
])