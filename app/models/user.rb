class User < ActiveRecord::Base
  has_many :favorites
  
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise  :database_authenticatable, :rememberable, 
          :trackable, :validatable, :lockable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :username, :role, :email, :password, :clearance, :remember_me, :first_name, :last_name
  
  #
  # Define which roles will be utilized/authorized in this application. 
  # They will be stored via a bitmap mask, so don't mix up the order, only append
  #
  ROLES = %w[staff manager admin]
  
  # Role Inheritiance
  def role?(base_role)
    ROLES.index(base_role.to_s) <= ROLES.index(role)
  end

end
