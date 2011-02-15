class User < ActiveRecord::Base
  has_many :bookmarks
  
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise  :database_authenticatable, :rememberable, 
          :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :username, :email, :password, :clearance, :remember_me, :first_name, :last_name
  
  
end
