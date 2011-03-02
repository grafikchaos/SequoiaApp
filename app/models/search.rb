class Search

  attr_accessor :query, :result

  def initialize(query, model = nil)
    self.query = query
    if model.nil?
      query.starts_with?('$') ? advanced : simple
    else
      model_search(model)
    end
  end

  ### PRIVATE METHODS BELOW ###
  private

  def simple
    self.result = Client.simple_search(self.query)
  end

  def advanced
    self.result = []
    # Remove the first $ to make our split cleaner.
    q = self.query.sub('$', '')
    q.split(/\$/).each do |clause|
      split = clause.scan(/[^\s]+/)
      client_code = split.first
      row_value = split.values_at(1..split.count).join(' ').rstrip
      self.result.concat(Entity.advanced_search(client_code, '', row_value))
    end
  end

  def split_types(part)
      
  end

  def model_search(model)
    self.result = model.classify.constantize.find_all_by_name(self.query)
  end
end
