class SessionsController < Devise::SessionsController
  layout 'no_sidebar', :only => 'new'

  # Create an audit record
  after_filter :add_audit, :only => [:create, :destroy]

end
