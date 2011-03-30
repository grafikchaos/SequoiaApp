# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

EntityType.create([
  { :name => 'API' },
  { :name => 'Application' },
  { :name => 'Computer' },
  { :name => 'Database' },
  { :name => 'Email' },
  { :name => 'FTP' },
  { :name => 'Payment Gateway' },
  { :name => 'Remote Desktop' },
  { :name => 'SSH' },
  { :name => 'Version Control' },
  { :name => 'VPN' },
  { :name => 'Website' },
  { :name => 'Wireless' }
])

EntityKey.create([
  { :name => 'Username' },
  { :name => 'Password', :mask => true },
  { :name => 'Email Address' },
  { :name => 'Host' },
  { :name => 'Database Name' },
  { :name => 'URL' },
  { :name => 'Token' },
  { :name => 'API Key' },
  { :name => 'Port' },
  { :name => 'Domain' },
  { :name => 'Protocol' },
  { :name => 'Encryption Key', :mask => true },
  { :name => 'Endpoint URL' },
  { :name => 'Transaction Key', :mask => true },
  { :name => 'WSDL URL' },
])

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

  { :entity_type_id => EntityType.find_by_name('Payment Gateway').id, :name => 'authorize'},
  { :entity_type_id => EntityType.find_by_name('Payment Gateway').id, :name => 'authorize.net'},
  { :entity_type_id => EntityType.find_by_name('Payment Gateway').id, :name => 'paypal'},
  { :entity_type_id => EntityType.find_by_name('Payment Gateway').id, :name => 'paypal.com'},

  { :entity_type_id => EntityType.find_by_name('Remote Desktop').id, :name => 'rdc'},

  { :entity_type_id => EntityType.find_by_name('SSH').id, :name => 'terminal'},
  { :entity_type_id => EntityType.find_by_name('SSH').id, :name => 'shell'},
  { :entity_type_id => EntityType.find_by_name('SSH').id, :name => 'console'},
  { :entity_type_id => EntityType.find_by_name('SSH').id, :name => 'bash'},
  { :entity_type_id => EntityType.find_by_name('SSH').id, :name => 'zsh'},
  { :entity_type_id => EntityType.find_by_name('SSH').id, :name => 'iterm'},

  { :entity_type_id => EntityType.find_by_name('Version Control').id, :name => 'vcs'},
  { :entity_type_id => EntityType.find_by_name('Version Control').id, :name => 'scm'},
  { :entity_type_id => EntityType.find_by_name('Version Control').id, :name => 'git'},
  { :entity_type_id => EntityType.find_by_name('Version Control').id, :name => 'get'},
  { :entity_type_id => EntityType.find_by_name('Version Control').id, :name => 'svn'},
  { :entity_type_id => EntityType.find_by_name('Version Control').id, :name => 'subversion'},
  { :entity_type_id => EntityType.find_by_name('Version Control').id, :name => 'dvcs'},
  { :entity_type_id => EntityType.find_by_name('Version Control').id, :name => 'cvs'},

  { :entity_type_id => EntityType.find_by_name('Website').id, :name => 'www'},
  { :entity_type_id => EntityType.find_by_name('Website').id, :name => 'url'},
  { :entity_type_id => EntityType.find_by_name('Website').id, :name => 'site'},
  { :entity_type_id => EntityType.find_by_name('Website').id, :name => 'href'},
  { :entity_type_id => EntityType.find_by_name('Website').id, :name => 'http'},
  { :entity_type_id => EntityType.find_by_name('Website').id, :name => 'https'},

  { :entity_type_id => EntityType.find_by_name('Wireless').id, :name => 'wpa'},
  { :entity_type_id => EntityType.find_by_name('Wireless').id, :name => 'wep'},
  { :entity_type_id => EntityType.find_by_name('Wireless').id, :name => 'wifi'}
])

FormConfig.create([
  { :entity_type_id => EntityType.find_by_name('Computer').id, :entity_key_id => EntityKey.find_by_name('Username').id, :sort_order => 0},
  { :entity_type_id => EntityType.find_by_name('Computer').id, :entity_key_id => EntityKey.find_by_name('Password').id, :sort_order => 1},

  { :entity_type_id => EntityType.find_by_name('Database').id, :entity_key_id => EntityKey.find_by_name('Username').id, :sort_order => 0},
  { :entity_type_id => EntityType.find_by_name('Database').id, :entity_key_id => EntityKey.find_by_name('Password').id, :sort_order => 1},
  { :entity_type_id => EntityType.find_by_name('Database').id, :entity_key_id => EntityKey.find_by_name('Host').id, :sort_order => 2},
  { :entity_type_id => EntityType.find_by_name('Database').id, :entity_key_id => EntityKey.find_by_name('Database Name').id, :sort_order => 3},
  { :entity_type_id => EntityType.find_by_name('Database').id, :entity_key_id => EntityKey.find_by_name('Port').id, :sort_order => 4},

  { :entity_type_id => EntityType.find_by_name('Email').id, :entity_key_id => EntityKey.find_by_name('Email Address').id, :sort_order => 0},
  { :entity_type_id => EntityType.find_by_name('Email').id, :entity_key_id => EntityKey.find_by_name('Password').id, :sort_order => 1},
  { :entity_type_id => EntityType.find_by_name('Email').id, :entity_key_id => EntityKey.find_by_name('Host').id, :sort_order => 2},
  { :entity_type_id => EntityType.find_by_name('Email').id, :entity_key_id => EntityKey.find_by_name('Protocol').id, :sort_order => 3},
  { :entity_type_id => EntityType.find_by_name('Email').id, :entity_key_id => EntityKey.find_by_name('Port').id, :sort_order => 4},

  { :entity_type_id => EntityType.find_by_name('FTP').id, :entity_key_id => EntityKey.find_by_name('Username').id, :sort_order => 0},
  { :entity_type_id => EntityType.find_by_name('FTP').id, :entity_key_id => EntityKey.find_by_name('Password').id, :sort_order => 1},
  { :entity_type_id => EntityType.find_by_name('FTP').id, :entity_key_id => EntityKey.find_by_name('Host').id, :sort_order => 2},
  { :entity_type_id => EntityType.find_by_name('FTP').id, :entity_key_id => EntityKey.find_by_name('Port').id, :sort_order => 3},

  { :entity_type_id => EntityType.find_by_name('Payment Gateway').id, :entity_key_id => EntityKey.find_by_name('Username').id, :sort_order => 0},
  { :entity_type_id => EntityType.find_by_name('Payment Gateway').id, :entity_key_id => EntityKey.find_by_name('Password').id, :sort_order => 1},
  { :entity_type_id => EntityType.find_by_name('Payment Gateway').id, :entity_key_id => EntityKey.find_by_name('Transaction Key').id, :sort_order => 2},
  { :entity_type_id => EntityType.find_by_name('Payment Gateway').id, :entity_key_id => EntityKey.find_by_name('API Key').id, :sort_order => 3},

  { :entity_type_id => EntityType.find_by_name('Remote Desktop').id, :entity_key_id => EntityKey.find_by_name('Username').id, :sort_order => 0},
  { :entity_type_id => EntityType.find_by_name('Remote Desktop').id, :entity_key_id => EntityKey.find_by_name('Password').id, :sort_order => 1},
  { :entity_type_id => EntityType.find_by_name('Remote Desktop').id, :entity_key_id => EntityKey.find_by_name('Host').id, :sort_order => 2},

  { :entity_type_id => EntityType.find_by_name('SSH').id, :entity_key_id => EntityKey.find_by_name('Username').id, :sort_order => 0},
  { :entity_type_id => EntityType.find_by_name('SSH').id, :entity_key_id => EntityKey.find_by_name('Password').id, :sort_order => 1},
  { :entity_type_id => EntityType.find_by_name('SSH').id, :entity_key_id => EntityKey.find_by_name('Host').id, :sort_order => 2},
  { :entity_type_id => EntityType.find_by_name('SSH').id, :entity_key_id => EntityKey.find_by_name('Port').id, :sort_order => 3},

  { :entity_type_id => EntityType.find_by_name('Version Control').id, :entity_key_id => EntityKey.find_by_name('Username').id, :sort_order => 0},
  { :entity_type_id => EntityType.find_by_name('Version Control').id, :entity_key_id => EntityKey.find_by_name('Password').id, :sort_order => 1},
  { :entity_type_id => EntityType.find_by_name('Version Control').id, :entity_key_id => EntityKey.find_by_name('Host').id, :sort_order => 2},
  { :entity_type_id => EntityType.find_by_name('Version Control').id, :entity_key_id => EntityKey.find_by_name('Protocol').id, :sort_order => 3},

  { :entity_type_id => EntityType.find_by_name('Website').id, :entity_key_id => EntityKey.find_by_name('URL').id, :sort_order => 0},
  { :entity_type_id => EntityType.find_by_name('Website').id, :entity_key_id => EntityKey.find_by_name('Username').id, :sort_order => 1},
  { :entity_type_id => EntityType.find_by_name('Website').id, :entity_key_id => EntityKey.find_by_name('Password').id, :sort_order => 2},

  { :entity_type_id => EntityType.find_by_name('Wireless').id, :entity_key_id => EntityKey.find_by_name('Password').id, :sort_order => 0},
  { :entity_type_id => EntityType.find_by_name('Wireless').id, :entity_key_id => EntityKey.find_by_name('Protocol').id, :sort_order => 1},
])
