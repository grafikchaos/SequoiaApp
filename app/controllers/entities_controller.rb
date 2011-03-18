class EntitiesController < ApplicationController
  load_and_authorize_resource

  # GET /entities/new
  # GET /entities/new.xml
  def new
    @client = Client.find(params[:client_id])
    
    # Load in the config for the given entity type
    # and build the rows accordingly
    type = params[:entity_type_id] ? EntityType.find(params[:entity_type_id]) : EntityType.first
    type.form_configs.each do |row|
      @entity.entity_rows.build :entity_key_id => row.entity_key_id
    end

    # If the entity type has no config, just load a blank row
    if type.entity_type_config_rows.empty?
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

    # Create more rows for the user to add entity rows
    count = 3 - @entity.entity_rows.count
    if count > 1 
      count.times { @entity.entity_rows.build }
    else
      @entity.entity_rows.build
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
end
