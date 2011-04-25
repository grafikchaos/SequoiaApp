class User < ActiveRecord::Base
  has_many :favorites
  has_many :assignments
  has_many :roles, :through => :assignments
  
  # Include devise modules.
  devise  :database_authenticatable, :rememberable, 
          :trackable, :validatable, :lockable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :username, :role, :email, :password, :clearance, :remember_me, :first_name, :last_name, :full_name

  # Get the current user from the controller
  cattr_accessor :current_user
  
  # validations
  validates :username, :presence => true, :uniqueness => true, :length => (4..255)
  validates :email, :presence => true, :uniqueness => true, :length => (2..255), :format => { :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i }
  validates :full_name, :presence => true, :length => (2..255)

  # versioning
  has_paper_trail :only => [:username, :role, :email, :first_name, :last_name, :clearance]
  
  
  def has_role?(role_sym)
    roles.any? { |r| r.name.underscore.to_sym == role_sym }
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
  
  def to_s
    self.username
  end

end
