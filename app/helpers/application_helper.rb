module ApplicationHelper

  def format_clearance_select
    options = []
    (current_user.clearance..3).each do |number|
      options << ["Level #{number}", number]
    end
    return options
  end

  def format_roles_select
    options = []
    options << ['Admin', 'admin']
    options << ['Manager', 'manager']
    options << ['Staff', 'staff']
    return options
  end

  def link_to_add_fields(name, f, association, partial_name = nil)
    new_object = f.object.class.reflect_on_association(association).klass.new
    fields = f.fields_for(association, new_object, :child_index => "new_#{association}") do |builder|
      if !partial_name.nil?
        render partial_name, :f => builder
      else
        render association.to_s + "/form_fields", :f => builder
      end
    end
    link_to_function(name, "add_fields(this, \"#{association}\", \"#{escape_javascript(fields)}\")")
  end  

  def favable_link(obj)
    fav = Favorite.find_by_user_id_and_favable_id_and_favable_type(current_user.id, obj.id, obj.class.to_s)
    if fav.nil?
      link_to 'Favorite', favorites_path( :favorite => { :note => obj.to_s, :favable_type => obj.class.to_s, :favable_id => obj.id } ), :remote => true, :method => :post, :class => 'favorite-link tooltip', :title => 'Add as favorite'
    else
      link_to 'Unfavorite', fav, :remote => true, :method => :delete, :class => 'favorite-link tooltip faved', :title => 'Remove favorite'
    end
  end

  def edit_link(obj, *args)
    options         = args.first || {}
    options[:id]    = 'edit-' + link_id(obj)
    options[:class] = 'edit-link tooltip'
    options[:title] = 'Edit this ' + obj.class.to_s.tableize.gsub('_', ' ').singularize
    path = 'edit_' + obj.class.to_s.tableize.singularize + '_path'
    link_to 'Edit', method(path).call(obj), options
  end

  def destroy_link(obj, *args)
    options           = args.first || {}
    options[:id]      = 'delete-' + link_id(obj)
    options[:class]   = 'destroy-link tooltip'
    options[:title]   = 'Delete this ' + obj.class.to_s.tableize.gsub('_', ' ').singularize
    options[:confirm] = 'Are you sure?'
    options[:method]  = :delete

    link_to 'Destroy', obj, options
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

end
