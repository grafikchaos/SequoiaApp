class EntityTypesController < ApplicationController
  load_and_authorize_resource

  # GET /entity_types
  # GET /entity_types.xml
  def index
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @entity_types }
    end
  end

  # GET /entity_types/new
  # GET /entity_types/new.xml
  def new
    3.times { @entity_type.entity_type_aliases.build } 
    
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @entity_type }
    end
  end

  # GET /entity_types/1/edit
  def edit
     @entity_type.entity_type_aliases.build
  end

  # POST /entity_types
  # POST /entity_types.xml
  def create
    respond_to do |format|
      if @entity_type.save
        format.html { redirect_to(entity_types_path, :notice => 'Entity Type was successfully created') }
        format.xml  { render :xml => @entity_type, :status => :created, :location => @entity_type }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @entity_type.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /entity_types/1
  # PUT /entity_types/1.xml
  def update
    respond_to do |format|
      if @entity_type.update_attributes(params[:entity_type])
        format.html { redirect_to(entity_types_path, :notice => 'Entity Type was successfully updated') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @entity_type.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /entity_types/1
  # DELETE /entity_types/1.xml
  def destroy
    @entity_type.destroy

    respond_to do |format|
      format.html { redirect_to(entity_types_url, :notice => 'Entity Type was successfully deleted') }
      format.xml  { head :ok }
    end
  end
end
