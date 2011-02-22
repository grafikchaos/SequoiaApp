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
    { :name => 'Database', :cached_slug => 'database' },
    { :name => 'SSH', :cached_slug => 'ssh' },
    { :name => 'Website', :cached_slug => 'website' },
    { :name => 'API', :cached_slug => 'api' },
    { :name => 'FTP', :cached_slug => 'ftp' },
    { :name => 'Application', :cached_slug => 'application' },
    { :name => 'Email', :cached_slug => 'email' }
  ])
end

if class_exists?('EntityKey')
  EntityKey.create([
    { :name => 'Username', :cached_slug => 'username' },
    { :name => 'Password', :cached_slug => 'password' },
    { :name => 'Email Address', :cached_slug => 'email_address' },
    { :name => 'Host', :cached_slug => 'host' },
    { :name => 'Database Name', :cached_slug => 'database_name' },
    { :name => 'URL', :cached_slug => 'url' },
    { :name => 'Token', :cached_slug => 'token' },
    { :name => 'API Key', :cached_slug => 'api_key' },
    { :name => 'Port', :cached_slug => 'port' }
  ])
end

if class_exists?('EntityTypeAlias')
  EntityTypeAlias.create([
    { :entity_type_id => EntityType.find_by_name('API').id, :name => 'soap'},
    { :entity_type_id => EntityType.find_by_name('API').id, :name => 'web service'},
    { :entity_type_id => EntityType.find_by_name('API').id, :name => 'rest'},
    { :entity_type_id => EntityType.find_by_name('API').id, :name => 'restful'},
    { :entity_type_id => EntityType.find_by_name('Application').id, :name => 'app'},

    { :entity_type_id => EntityType.find_by_name('Computer').id, :name => 'machine'},
    { :entity_type_id => EntityType.find_by_name('Computer').id, :name => 'pc'},
    { :entity_type_id => EntityType.find_by_name('Computer').id, :name => 'mac'},
    { :entity_type_id => EntityType.find_by_name('Computer').id, :name => 'desktop'},
    { :entity_type_id => EntityType.find_by_name('Computer').id, :name => 'laptop'},

    { :entity_type_id => EntityType.find_by_name('Database').id, :name => 'db'},
    { :entity_type_id => EntityType.find_by_name('Database').id, :name => 'mysql'},
    { :entity_type_id => EntityType.find_by_name('Database').id, :name => 'sql'},
    { :entity_type_id => EntityType.find_by_name('Database').id, :name => 'sequel'},
    { :entity_type_id => EntityType.find_by_name('Database').id, :name => 'mongo'},
    { :entity_type_id => EntityType.find_by_name('Database').id, :name => 'mongodb'},
    { :entity_type_id => EntityType.find_by_name('Database').id, :name => 'ms sql'},
    { :entity_type_id => EntityType.find_by_name('Database').id, :name => 'mssql'},
    { :entity_type_id => EntityType.find_by_name('Database').id, :name => 'cassandra'},
    { :entity_type_id => EntityType.find_by_name('Database').id, :name => 'mariadb'},
    { :entity_type_id => EntityType.find_by_name('Database').id, :name => 'postgre'},
    { :entity_type_id => EntityType.find_by_name('Database').id, :name => 'postgresql'},
    { :entity_type_id => EntityType.find_by_name('Database').id, :name => 'couch'},
    { :entity_type_id => EntityType.find_by_name('Database').id, :name => 'couchdb'},
    { :entity_type_id => EntityType.find_by_name('Database').id, :name => 'sqllite'},
    { :entity_type_id => EntityType.find_by_name('Database').id, :name => 'sql lite'},

    { :entity_type_id => EntityType.find_by_name('Email').id, :name => 'e-mail'},
    { :entity_type_id => EntityType.find_by_name('Email').id, :name => 'mail'},
    { :entity_type_id => EntityType.find_by_name('Email').id, :name => 'outlook'},
    { :entity_type_id => EntityType.find_by_name('Email').id, :name => 'webmail'},

    { :entity_type_id => EntityType.find_by_name('FTP').id, :name => 'sftp'},


  ])

sftp                                                                                                            
authorize, authorize.net, paypal, paypal.com                                                                    
rdc                                                                                                             
terminal, shell, bash, zsh, iterm, console                                                                      
vcs, scm, git, get, svn, dvcs, cvs, subversion                                                                  
                                                                                                                
www, url, site, href, http, https                                                                               
wpa, wep, wifi                                                                                                  




  

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
