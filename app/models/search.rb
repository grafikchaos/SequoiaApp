class Search

  attr_accessor :query, :result

  def initialize(query)
    self.query = query
    query.starts_with?('$') ? advanced : simple
  end

  ### PRIVATE METHODS BELOW ###
  private

  def simple
    self.result = Client.simple_search(self.query)
  end

  def advanced
    self.query.split(/\$/).each do |part|
      split_types(part)
    end
  end

  def split_types(part)
      
  end

end
