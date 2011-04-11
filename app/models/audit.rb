class Audit < ActiveRecord::Base
  belongs_to :user

  default_scope includes(:user).order("created_at DESC")

  scope :message_contains?, lambda { |string| where('message LIKE ?', "%#{string}%") } 

end
