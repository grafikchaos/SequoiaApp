class User < ActiveRecord::Base
  has_many :favorites
  
  # Include devise modules.
  devise  :database_authenticatable, :rememberable, 
          :trackable, :validatable, :lockable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :username, :role, :email, :password, :clearance, :remember_me, :first_name, :last_name, :full_name
  
  # validations
  validates_presence_of :username, :email, :full_name

  # versioning
  has_paper_trail :only => [:username, :role, :email, :first_name, :last_name, :clearance]
  
  #
  # Define which roles will be utilized/authorized in this application. 
  # They will be stored via a bitmap mask, so don't mix up the order, only append
  #
  ROLES = %w[staff manager admin]
  
  # Role Inheritiance
  def role?(base_role)
    ROLES.index(base_role.to_s) <= ROLES.index(role)
  end
  
  # GETTER - combine the first and last names
  def full_name
    [first_name, last_name].join(' ')  
  end
  
  # SETTER - split the full name into 2 parts (first, last) by splitting on the space
  def full_name=(name)  
      split = name.split(' ', 2)  
      self.first_name = split.first  
      self.last_name = split.last  
  end
  

end
