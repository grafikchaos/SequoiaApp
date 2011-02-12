module NavigationHelpers
  # Maps a name to a path. Used by the
  #
  #   When /^I go to (.+)$/ do |page_name|
  #
  # step definition in web_steps.rb
  #
  def path_to(page_name)
    case page_name

    when /the home\s?page/
      '/'

    when /^the login page$/
      new_user_session_path

    when /^the list of clients$/
      "/clients"

    when /^the client page for "(.*)"$/i
      client_path(Client.find_by_client_code($1))

    when /^the edit page for the client "(.*)"$/i
      edit_client_path(Client.find_by_client_code($1))

    when /"(.*)"'s new project page$/i
      client = Client.find_by_client_code($1)
      new_client_project_path(client)

    when /the list of projects for "(.*)"$/i
      client = Client.find_by_client_code($1)
      client_projects_path(client)

    else
      begin
        page_name =~ /the (.*) page/
        path_components = $1.split(/\s+/)
        self.send(path_components.push('path').join('_').to_sym)
      rescue Object => e
        raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
          "Now, go and add a mapping in #{__FILE__}"
      end

    end
  end
end

World(NavigationHelpers)
