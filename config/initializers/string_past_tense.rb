class String
 
  # Extension to make things past tense
  def past_tense
    case true
      when self.end_with?('e')
        self + 'd'
      else
        self + 'ed'
    end
  end
 
end

