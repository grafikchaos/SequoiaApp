class Note < ActiveRecord::Base
  belongs_to :notable, :polymorphic => true

  # validates_presence_of :notable_id, :notable_type, :content
  # validates_length_of :content, :minimum => 1
  
  attr_accessible :notable_id, :notable_type, :content
end
