module BookmarksHelper

  def format_bookmark(mark)
    if mark.client_id
      client = Client.find(mark.client_id)
      link_to client.name, client_path(client)
    elsif mark.project_id
      project = Project.find(mark.project_id)
      link_to "#{project.client.client_code}-#{project.name}", client_path(project.client)
    else
      mark.query
      # do something
    end
  end

end
