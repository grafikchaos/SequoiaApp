class EntitiesController < ApplicationController
  load_and_authorize_resource

  # GET /entities/1
  # GET /entities/1.xml
  def show

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @entity }
    end
  end

  # GET /entities/new
  # GET /entities/new.xml
  def new
    @client = Client.find(params[:client_id])
    @projects = @client.projects
    @entity_types = EntityType.all
    
    # Start off with 3 empty rows.
    3.times { @entity.entity_rows.build }
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
    @projects = @client.projects
    @entity_types = EntityType.all

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
    @project = Project.find(params[:entity][:project_id])
    @client = @project.client

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
