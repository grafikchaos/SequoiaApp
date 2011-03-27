class Note < ActiveRecord::Base
  belongs_to :notable, :polymorphic => true

  attr_accessible :notable_id, :notable_type, :content, :markup

  # For determining markup language
  def to_markup
    case self.markup
      when 'Markdown'
        require 'rdiscount'
        RDiscount.new(self.content).to_html
      when 'Textile'
        require 'RedCloth'
        RedCloth.new(self.content).to_html
    end
  end

end
