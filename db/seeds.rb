# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

def class_exists?(class_name)
  klass = Module.const_get(class_name)
  return klass.is_a?(Class)
rescue NameError
  return false
end

if class_exists?('Client')
  Client.create([
    { :name => 'Test, Inc.', :client_code => 'TEST' }
  ])
end

if class_exists?('EntityType')
  EntityType.create([
    { :name => 'Database' },
    { :name => 'SSH' },
    { :name => 'Website' },
    { :name => 'API' },
    { :name => 'FTP' },
    { :name => 'Application' },
    { :name => 'Email' }
  ])
end

if class_exists?('EntityAttribute')
  EntityAttribute.create([
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
end

if class_exists?('User')
  users = User.create([
    { 
      :username => 'testuser', 
      :email => 'test@test.com', 
      :password => 'password',  
      :first_name => 'Test', 
      :last_name => 'User' 
    }
  ])
end
