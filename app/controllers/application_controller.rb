class ApplicationController < ActionController::Base
  protect_from_forgery
  
  before_filter :authenticate_user!
  
  rescue_from CanCan::AccessDenied do |exception|
    render :file => "#{Rails.root}/public/403.html", :status => 403, :layout => false
  end 

  def add_audit
    obj = self.instance_variable_get("@#{controller_name.singularize}")
    Audit.create(
      :message => "#{controller_name.singularize.capitalize} #{action_name}d by %user", 
      :controller_info => "#{controller_name}##{action_name}",
      :user_id => current_user.id,
      :model_id => obj.id,
      :model_type => obj.class.to_s
    )
  end

end
