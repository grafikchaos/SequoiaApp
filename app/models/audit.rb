class Audit < ActiveRecord::Base
  belongs_to :user

  # Callbacks
  before_create :format_message

  default_scope includes(:user).order("created_at DESC")

  scope :message_contains?, lambda { |string| where('message LIKE ?', "%#{string}%") } 


  ## PRIVATE ##
  private

  def format_message
    self.message.gsub!('%user', User.find(self.user_id).username)

    if self.model_type == 'EntityRow'
      self.message.gsub!('%client', self.model_type.constantize.find(self.model_id).entity.project.client.name)
    end
  end

end
