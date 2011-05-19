require 'highline'
namespace :sequoia do
  namespace :setup do
    desc "Create User accounts with Role = Owner using rake - prompting for user name and password. NOTE: Owner accounts will only be setup if there is NO other user with the role owner assigned, otherwise account creation is skipped"
    task :owner => :environment do
      role = Role.find_or_initialize_by_name('owner')
      role.is_system = true
      role.save!
      
      existing_owners = UserRole.find_by_role_id(role.id)
      
      if existing_owners.blank?
        ui = HighLine.new
        name     = ui.ask("Full Name: ")
        email    = ui.ask("Email: ")
        login    = ui.ask("Username: ")
        password = ui.ask("Password: ") { |q| q.echo = false }
      
        user = User.new(
          :full_name              => name, 
          :email                  => email, 
          :username               => login, 
          :password               => password, 
          :password_confirmation  => password
        )
      
        if user.save(false)
          UserRole.create!(:user_id => user.id, :role_id => role.id)
          puts "Owner User account '#{login}' created."
        else
          puts "Problem creating user account:"
          puts user.errors.full_messages
        end
      else
        puts "An Owner Account already exists! Skipping creation of Owner Account."
      end
    end
  end
end