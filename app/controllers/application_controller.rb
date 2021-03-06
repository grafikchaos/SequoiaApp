class ApplicationController < ActionController::Base
  protect_from_forgery
  
  before_filter :authenticate_user!,
                :set_current_user, 
                :sidebar_visibility, 
                :welcome_message
  
  rescue_from CanCan::AccessDenied do |exception|
    render :file => "#{Rails.root}/public/403.html", :status => 403, :layout => false
  end 

  def current_ability
    current_user.ability
  end

  def set_current_user
    User.current_user = current_user
  end

  def add_audit
    if Rails.env != "test"
      obj = self.instance_variable_get("@#{controller_name.singularize}")
      audit = Audit.new
      audit.message = "#{controller_name.singularize.capitalize} #{action_name.past_tense} by #{current_user.username}"
      audit.controller_info = "#{controller_name}##{action_name}"
      audit.user_id = current_user.id
      audit.model_id = obj.id unless obj.nil?
      audit.model_type = obj.class.to_s unless obj.nil?
      audit.save
    end
  end

  def sidebar_visibility
    @show_sidebar = cookies[:sequoia_sidebar]
  end

  def welcome_message
    @welcome_message = WelcomeMessage.random
  end

end
