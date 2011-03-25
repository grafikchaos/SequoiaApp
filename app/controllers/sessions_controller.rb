class SessionsController < Devise::SessionsController
  layout 'no_sidebar', :only => 'new'
end
