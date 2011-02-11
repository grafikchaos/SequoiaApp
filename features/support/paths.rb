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

    when /^the list of clients$/
      "/clients"

    when /^the client page for "(.*)"$/i
      client_path(Client.find_by_client_code($1))

    when /^the edit page for the client "(.*)"$/i
      edit_client_path(Client.find_by_client_code($1))

    when /"(.*)"'s new project page$/i
      client = Client.find_by_client_code($1)
      new_client_project_path(client)

    when /"(.*)"'s "(.*)" project page$/i
      client = Client.find_by_client_code($1)
      project = Project.find_by_name($2)
      client_project_path(client, project)

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
