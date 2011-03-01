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
    self.query.split(/\$/).each do |part|
      if !part.blank?
        split = part.scan(/[^\s]+/)
        client_code = split.first
        self.result.concat(Entity.filter_by_row(client_code, split.values_at(1..split.count).join(' ').rstrip))
      end
    end
  end

  def split_types(part)
      
  end

  def model_search(model)
    self.result = model.classify.constantize.find_all_by_name(self.query)
  end
end
