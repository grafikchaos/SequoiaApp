class Note < ActiveRecord::Base
  belongs_to :notable, :polymorphic => true

  validates_presence_of :notable_id, :notable_type, :content
end
