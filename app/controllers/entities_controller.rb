class EntitiesController < ApplicationController
  load_and_authorize_resource
  before_filter :load_form_config, :only => [:new, :edit]

  # GET /entities/new
  # GET /entities/new.xml
  def new
    @client = Client.find(params[:client_id])

    # If the entity type has no config, just load a blank row
    if @form_config.empty?
      @entity.entity_rows.build
    end

    # Start off with 1 note field
    1.times { @entity.notes.build }

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @entity }
    end
  end

  # GET /entities/1/edit
  def edit
    @client = @entity.project.client

    if @entity.notes.empty?
      @entity.notes.build
    end
  end

  # POST /entities
  # POST /entities.xml
  def create
    @client = Client.find(params[:client_id])

    respond_to do |format|
      if @entity.save
        format.html { redirect_to(@client, :notice => 'Entity was successfully created.') }
        format.xml  { render :xml => @entity, :status => :created, :location => @entity }
      else
        # load in the form config so we can re-construct the form
        load_form_config

        format.html { render :action => "new" }
        format.xml  { render :xml => @entity.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /entities/1
  # PUT /entities/1.xml
  def update
    @project = Project.find(params[:entity][:project_id])
    @client = @project.client

    respond_to do |format|
      if @entity.update_attributes(params[:entity])
        format.html { redirect_to(@client, :notice => 'Entity was successfully updated.') }
        format.xml  { head :ok }
      else
        # load in the form config so we can re-construct the form
        load_form_config

        format.html { render :action => "edit" }
        format.xml  { render :xml => @entity.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /entities/1
  # DELETE /entities/1.xml
  def destroy
    @client = @entity.project.client
    @entity.destroy

    respond_to do |format|
      format.html { redirect_to(@client) }
      format.xml  { head :ok }
    end
  end

  # Load the form config
  def load_form_config
    @form_config = FormConfig.get_for_type(@entity.entity_type_id || params[:entity_type_id])

    confs = []
    @entity.entity_rows.each do |row|
      confs << row.form_config_id
    end

    @form_config.each_with_index do |row, index|
      if !confs.include?(row.id)
        @entity.entity_rows.insert(index, EntityRow.new(:entity_id => @entity.id, :entity_key_id => row.entity_key_id, :form_config_id => row.id.to_s))
      end
    end
  end

end
