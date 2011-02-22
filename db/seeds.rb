# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

EntityType.create([
  { :name => 'Database' },
  { :name => 'SSH' },
  { :name => 'Website' },
  { :name => 'API' },
  { :name => 'FTP' },
  { :name => 'Application' },
  { :name => 'Email' },
  { :name => 'Computer' },
  { :name => 'Payment Gateway' },
  { :name => 'Remote Desktop' },
  { :name => 'Version Control' },
  { :name => 'VPN' },
  { :name => 'Wireless' },
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
