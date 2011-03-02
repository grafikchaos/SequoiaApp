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

      # Divide the string on spaces.
      words = clause.scan(/[^\s]+/)

      # Client code will always be first, so we capture and remove it.
      client_code = words.first
      words.delete_at(0)
      
      # Put the rest back together.
      string = words.join(' ').rstrip

      if string.include? "#"
        # Remove the first $ to make our split cleaner.
        string.sub!('#', '')
        string.split(/#/).each do |type_clause|

          # Divide the string on spaces again.
          words2 = type_clause.scan(/[^\s]+/)
          type = words2.first
          words2.delete_at(0)
          puts "Type: #{type}, cc: #{client_code}"

          # Put the rest back together.
          string2 = words2.join(' ').rstrip
          self.result.concat(Entity.advanced_search(client_code, type, string2))
        end
      else
        self.result.concat(Entity.advanced_search(client_code, '', string))
      end
    end
  end

  def split_types(part)
      
  end

  def model_search(model)
    self.result = model.classify.constantize.find_all_by_name(self.query)
  end
end
