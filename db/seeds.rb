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

# if class_exists?('EntityType')
#   EntityType.create([
#     { :name => 'Database', :cached_slug => 'database' },
#     { :name => 'SSH', :cached_slug => 'ssh' },
#     { :name => 'Website', :cached_slug => 'website' },
#     { :name => 'API', :cached_slug => 'api' },
#     { :name => 'FTP', :cached_slug => 'ftp' },
#     { :name => 'Application', :cached_slug => 'application' },
#     { :name => 'Email', :cached_slug => 'email' }
#   ])
# end
# 
# if class_exists?('EntityKey')
#   EntityKey.create([
#     { :name => 'Username', :cached_slug => 'username' },
#     { :name => 'Password', :cached_slug => 'password' },
#     { :name => 'Email Address', :cached_slug => 'email_address' },
#     { :name => 'Host', :cached_slug => 'host' },
#     { :name => 'Database Name', :cached_slug => 'database_name' },
#     { :name => 'URL', :cached_slug => 'url' },
#     { :name => 'Token', :cached_slug => 'token' },
#     { :name => 'API Key', :cached_slug => 'api_key' },
#     { :name => 'Port', :cached_slug => 'port' }
#   ])
# end

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
