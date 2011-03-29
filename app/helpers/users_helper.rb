module UsersHelper

  def unlock_link(user)
    options = {}
    options[:class] = 'unlock-link tooltip'
    options[:id] = "unlock-#{user.username}"
    options[:confirm] = 'Are you sure you want to unlock this user account?'
    options['data-tooltip'] = "This user's account has been locked because they had 10 failed login attempts. Click here to unlock their account."
    link_to "Unlock this User", user_unlock_path(user), options
  end

end
