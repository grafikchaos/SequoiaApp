module FavoritesHelper

  def link_to_favorite(favorite)
    case favorite.favable_type
      when 'Client'
        link_to favorite.note, client_path(Client.find(favorite.favable_id))
      when 'Project'
        project = Project.find(favorite.favable_id)
        link_to favorite.note, client_path(project.client, :project => project.id)
      when 'QueryString'
        link_to favorite.note, root_path(:query => QueryString.find(favorite.favable_id).string)
    end 
  end

end
