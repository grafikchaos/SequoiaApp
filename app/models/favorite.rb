class Favorite < ActiveRecord::Base
  include ActsAsFavable::Favorite

  # NOTE: Favorite belongs to a user
  belongs_to :user
  belongs_to :favable, :polymorphic => true

  # default scope
  default_scope :order => 'created_at ASC'

  attr_accessible :favable_type, :favable_id, :note, :name, :user_id
end
