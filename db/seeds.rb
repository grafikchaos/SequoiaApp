# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

clients = Client.create([
  { :name => 'Test, Inc.', :client_code => 'TEST' }
])

entity_types = EntityType.create([
  { :name => 'Database' },
  { :name => 'SSH' },
  { :name => 'Website' },
  { :name => 'API' },
  { :name => 'FTP' },
  { :name => 'Application' },
  { :name => 'Email' }
])

entity_attributes = EntityAttribute.create([
  { :name => 'Username' },
  { :name => 'Password' },
  { :name => 'Email Address' },
  { :name => 'Host' },
  { :name => 'Database Name' },
  { :name => 'URL' },
  { :name => 'Token' },
  { :name => 'API Key' },
  { :name => 'Port' }
])

users = User.create([
  { 
    :username => 'testuser', 
    :email => 'test@test.com', 
    :password => 'password', 
    :password_confirmation => 'password', 
    :first_name => 'Test', 
    :last_name => 'User' 
  }
])
