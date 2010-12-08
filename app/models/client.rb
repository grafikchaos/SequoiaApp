class Client < ActiveRecord::Base
  
  validates_presence_of :name, :client_code
  has_many :projects, :dependent => :destroy
  
end
