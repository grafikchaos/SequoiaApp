class Audit < ActiveRecord::Base
  belongs_to :user

  default_scope includes(:user).order("created_at DESC")

  def message_formatted(emphasize = false)
    message.gsub('%user', emphasize ? '<em>'+self.user.username+'</em>' : self.user.username)
  end

end
