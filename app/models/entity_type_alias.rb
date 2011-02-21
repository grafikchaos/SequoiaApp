class EntityTypeAlias < ActiveRecord::Base
  belongs_to :entity_type

  validates_uniqueness_of :name
  validates_presence_of :name, :entity_type_id
end
