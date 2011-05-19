class WelcomeMessage < ActiveRecord::Base

  def self.random
    if (c = count) != 0
      find(:first, :offset => rand(c))
    end
  end

end
