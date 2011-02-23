module ApplicationHelper

  def format_for_select(items, all = nil)
    options = []
    options << [all, all.downcase] if all
    items.each do |item|
      options << [item.name, item.id]
    end
    return options
  end

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

  def link_to_add_fields(name, f, association, keys = nil, partial_name = nil)
    new_object = f.object.class.reflect_on_association(association).klass.new
    fields = f.fields_for(association, new_object, :child_index => "new_#{association}") do |builder|
      if !partial_name.nil?
        render partial_name, :f => builder
      else
        render association.to_s + "/form_fields", :f => builder, :entity_keys => keys
      end
    end
    link_to_function(name, "add_fields(this, \"#{association}\", \"#{escape_javascript(fields)}\")")
  end  

end
