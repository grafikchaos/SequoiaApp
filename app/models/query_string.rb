class QueryString < ActiveRecord::Base
  
  # For bookmarking
  acts_as_favable

  validates_presence_of :string

  def to_s
    self.string
  end

end
