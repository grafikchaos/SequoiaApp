class Entity < ActiveRecord::Base
  belongs_to  :project
  belongs_to  :entity_type
  has_many    :entity_rows
  has_many    :notes, :as => :notable
  
  # validations
  validates_presence_of :name, :project_id, :entity_type_id
  
  # accept Entity Row form fields/attributes
  accepts_nested_attributes_for :entity_rows, :reject_if => :should_not_save_or_validate_row?, :allow_destroy => true

  # accept Note form fields/attributes
  accepts_nested_attributes_for :notes, :reject_if => lambda { |note| note[:content].blank? }, :allow_destroy => true


  # friendly_id slug behavior
  has_friendly_id :name, 
                  :use_slug => true, 
                  :approximate_ascii => true,
                  :reserved_words => ['index', 'new', 'create', 'show', 'edit', 'update', 'delete', 'client', 'project', 'contact']
  
  # define which columns are mass-assignable
  attr_accessible :name, :project_id, :entity_type_id, :clearance, :entity_rows_attributes, :notes_attributes
  
  # setting the default scope
  default_scope includes(:entity_rows).order(:project_id)

  # Named scopes

  # Scopes for searching
  scope :limit_client, lambda { |code| includes({:project => :client }).where(:clients => {:client_code => code }) }
  scope :limit_type, lambda { |type| 
    unless type.blank?
      includes( { :entity_type  => :entity_type_aliases } ).where({ :entity_types => [ :name => type ] } | { :entity_type_aliases => [ :name => type] } ) 
    end
  }
  scope :filter_by_row, lambda { |value| 
    unless value.blank?
      includes({:entity_rows => :entity_key}).where( { :name.matches => "%#{value}%" } | { :entity_rows => [:encrypted_value => EntityRow.encrypt_value(value)] } )
    end
  }
  scope :advanced_search, lambda { |code, type, value| limit_client(code).limit_type(type).filter_by_row(value) }

  ##############################
  # Private methods below here!
  ##############################
  private

    # 
    # Determine when to reject an entity row
    # 
    # EntityRow should NOT be saved if the :value is blank AND
    # EntityRow should NOT be rejected if the :form_config_id is present OR 
    #   the FormConfig says the the row is NOT REQUIRED
    #   
    def should_not_save_or_validate_row?(row)
      if row[:form_config_id].blank?
        reject = true
      else
        # set reject to FALSE if the FormConfig says the row is REQUIRED
        reject = FormConfig.find(row[:form_config_id]).required ? false : true
      end
    
      # REJECT if the :value.blank? = true AND reject = true; otherwise let it be validated
      row[:value].blank? && reject
    end

end
