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

    when /^the search results page$/
      search_results_path

    when /^the login page$/
      new_user_session_path

    when /^the client page for "(.*)"$/i
      client_entities_path(Client.find($1))

    when /^the edit page for the client "(.*)"$/i
      edit_client_path(Client.find($1))

    when /^"(.*)"'s new project page$/i
      client = Client.find($1)
      new_client_project_path(client)

    when /^"(.*)"'s new entity page for entity type "(.*)"$/i
      type = EntityType.find_by_name($2)
      "/clients/#{$1.downcase}/entities/new?entity_type_id=#{type.id}"

    when /the list of projects for "(.*)"$/i
      client = Client.find($1)
      client_projects_path(client)

    when /the list of entities for "(.*)"$/i
      client = Client.find($1)
      client_entities_path(client)

    when /the list of my favorites$/i
      favorites_path

    when /the list of (.*)$/i
      class_name = $1.downcase 
      case class_name
        when "entity types"
          entity_types_path
        when "entity keys"
          entity_keys_path
        when "users"
          users_path
      end

    when /the new (.*) page$/i
      class_name = $1.downcase 
      case class_name
        when "entity type"
          new_entity_type_path
        when "client"
          new_client_path
      end
      
    when /the edit (.*) page for "(.*)"$/i
      class_name = $1.downcase
      case class_name
        when "entity type"
          @entity = EntityType.find("#{$2}".downcase)
          edit_entity_type_path(@entity)
      end
      
    when /^a non-existent page$/i
      '/iehrgoinboiuubewuoebfouwbdinv'
      
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
