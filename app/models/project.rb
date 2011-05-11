class Project < ActiveRecord::Base

  # relationships
  belongs_to  :client
  has_many    :entities
  has_many    :notes, :as => :notable
  
  # For bookmarking
  acts_as_favable

  # validations
  validates_presence_of   :client_id
  validates_presence_of   :name
  validates_uniqueness_of :name, :scope => [:client_id], :case_sensitive => false

  # accept Note form fields/attributes
  accepts_nested_attributes_for :notes, :reject_if => lambda { |note| note[:content].blank? }, :allow_destroy => true

  # define which columns are mass-assignable
  attr_accessible :name, :client_id, :domain, :notes_attributes

  # versioning
  has_paper_trail :only => [:name, :domain, :client_id]

  def to_s
    self.name
  end
  
end
