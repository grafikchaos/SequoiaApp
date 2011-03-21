class Search

  attr_accessor :query, :result

  def initialize(query, model = nil)
    @query = query
    @result = []
    if model.nil?
      query.starts_with?('$') ? advanced : simple
    else
      model_search(model)
    end
  end

  ### PRIVATE METHODS BELOW ###
  private

  def simple
    @result = Client.simple_search(self.query)
  end

  def advanced

    # Remove the first $ to make our split cleaner.
    q = @query.sub('$', '')
    q.split(/\$/).each do |clause|

      # Make sure the client code is nice.
      # Kind of hacky.
      next if clause.starts_with?(' ')

      # Divide the string on spaces.
      words = clause.split

      # Client code will always be first, so we capture and remove it.
      client_code = words.shift
      
      # Put the rest back together.
      string = words.join(' ').rstrip

      # If the rest is blank, just run the query
      # otherwise, loop and parse
      if string.blank?
        @result.concat(Entity.advanced_search(client_code, nil, nil))
      else
        string.scan(/(\#?[^#]*)/).each do |type_clause|
          type_clause = type_clause[0].rstrip
          next if type_clause.blank?
          if type_clause.include? "#"
            # Remove the first $ to make our split cleaner.
            type_clause.sub!('#', '') if type_clause.starts_with?('#')

            # Divide the string on spaces again.
            words2 = type_clause.split
            type = words2.shift

            # Put the rest back together.
            string2 = words2.join(' ').rstrip
            @result.concat(Entity.advanced_search(client_code, type, string2))
          else
            @result.concat(Entity.advanced_search(client_code, nil, type_clause))
          end
        end
      end
    end

    # Save the query string if it returns some results.
    if self.result
      QueryString.create :string => self.query if QueryString.find_by_string(self.query).nil?
    end

  end

  def model_search(model)
    self.result = model.classify.constantize.find_all_by_name(self.query)
  end
end
