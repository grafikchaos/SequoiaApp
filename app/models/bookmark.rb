class Bookmark < ActiveRecord::Base
  
  belongs_to :user
  
  validates_presence_of :user_id, :path
  validates_uniqueness_of :path, :scope => [:user_id], :case_sensitive => false
  
end
