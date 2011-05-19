require 'highline'
namespace :db do
  namespace :setup do
    desc "Create user accounts with rake, prompting for user name and password."
    task :user => :environment do
      ui = HighLine.new
      name     = ui.ask("Full Human name: ")
      email    = ui.ask("Email: ")
      login    = ui.ask("Username: ")
      password = ui.ask("Password: ") { |q| q.echo = false }
      
      user = User.new(:full_name => name, :email => email, :username => login, :password => password, :password_confirmation => password)
      if user.save false
        puts "User account '#{login}' created."
      else
        puts
        puts "Problem creating user account:"
        puts user.errors.full_messages
      end
    end

  end
end