module ApplicationHelper

  def link_to_add_fields(name, f, association, partial_name = nil)
    new_object = f.object.class.reflect_on_association(association).klass.new
    fields = f.fields_for(association, new_object, :child_index => "new_#{association}") do |builder|
      if !partial_name.nil?
        render partial_name, :f => builder
      else
        render association.to_s + "/form_fields", :f => builder
      end
    end
    link_to_function(name, "add_fields(this, \"#{association}\", \"#{escape_javascript(fields)}\")", :class => 'add-more-link')
  end  

  def favable_link(obj)
    fav = Favorite.find_by_user_id_and_favable_id_and_favable_type(current_user.id, obj.id, obj.class.to_s)
    if fav.nil?
      link_to 'Favorite', favorites_path( :favorite => { :note => obj.to_s, :favable_type => obj.class.to_s, :favable_id => obj.id } ), :remote => true, :method => :post, :class => 'favorite-link', :title => 'Add as favorite'
    else
      link_to 'Unfavorite', fav, :remote => true, :method => :delete, :class => 'favorite-link faved', :title => 'Remove favorite'
    end
  end

  def link_to_favorite(favorite)
    case favorite.favable_type
      when 'Client'
        link_to favorite.name, client_path(Client.find(favorite.favable_id))
      when 'Project'
        project = Project.find(favorite.favable_id)
        link_to favorite.name, client_path(project.client, :project => project.id)
      when 'QueryString'
        link_to favorite.name, search_results_path(:query => QueryString.find(favorite.favable_id).string)
    end 
  end

  def edit_link(obj, *args)
    sane            = obj.class.to_s.tableize.gsub('_', ' ').singularize.titleize
    options         = args.first || {}
    options[:id]    = 'edit-' + link_id(obj)
    options[:class] = 'edit-link'
    options[:title] = 'Edit this ' + sane 
    path = 'edit_' + obj.class.to_s.tableize.singularize + '_path'
    link_to 'Edit this ' + sane, method(path).call(obj), options
  end

  def destroy_link(obj, *args)
    sane              = obj.class.to_s.tableize.gsub('_', ' ').singularize.titleize
    options           = args.first || {}
    options[:id]      = 'delete-' + link_id(obj)
    options[:class]   = 'destroy-link'
    options[:title]   = 'Delete this ' + sane
    options[:confirm] = 'Are you sure?'
    options[:method]  = :delete

    link_to 'Delete this ' + sane, obj, options
  end

  def link_id(obj)
    if obj.respond_to?('friendly_id')
      obj.friendly_id
    elsif obj.respond_to?('username')
      obj.username.downcase
    elsif obj.respond_to?('name')
      obj.name.downcase.gsub(' ', '_')
    else
      obj.class.to_s.tableize.singularize +  "-" + obj.id.to_s
    end
  end

  def cycle_with_first_last(object, collection, options = { })
    options[:first] = options[:blank] || 'first'
    options[:last] = options[:last] || 'last'
    options[:odd] = options[:odd] || 'odd'
    options[:even] = options[:even] || 'even'
    addition = ""
    addition += " #{options[:first]}" if object == collection.first
    addition += " #{options[:last]}"if object == collection.last
    cycle(options[:odd], options[:even]) + addition
  end

  
  # set the checkbox to default to Staff if the Entity/User is a new record
  # otherwise use the databse values to set the checked attribute
  def default_assigned_roles_checkbox(obj)
    str = ""
    Role.all.each do |role|
      str += "<div><label class='checkbox'>"
      if obj.new_record?
        str += check_box_tag "#{obj.class.to_s.downcase}[role_ids][]", role.id, obj.roles.include?(role), :class => 'checkbox', :checked => role.name == 'staff'
      else
        str += check_box_tag "#{obj.class.to_s.downcase}[role_ids][]", role.id, obj.roles.include?(role), :class => 'checkbox'
      end
      str += role.name.titleize + "</label></div>"
    end
    
    # give back the raw HTML  
    raw(str)
  end

end
