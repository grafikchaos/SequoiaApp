module ApplicationHelper

  def format_for_select(items, all = nil)
    options = []
    options << [all, all.downcase] if all
    items.each do |item|
      options << [item.name, item.id]
    end
    return options
  end

end
