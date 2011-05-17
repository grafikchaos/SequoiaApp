class UserRole < ActiveRecord::Base

  # relationships
  belongs_to :role
  belongs_to :user

end
