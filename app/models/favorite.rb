class Favorite < ActiveRecord::Base
  include ActsAsFavable::Favorite

  belongs_to :favable, :polymorphic => true

  default_scope :order => 'created_at ASC'

  # NOTE: Favorite belongs to a user
  belongs_to :user

  attr_accessible :favable_type, :favable_id, :note, :user_id
end
