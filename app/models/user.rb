class User < ActiveRecord::Base
  
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise  :database_authenticatable, :rememberable, 
          :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :username, :email, :password, :remember_me, :first_name, :last_name
  
  has_many :bookmarks
  
end