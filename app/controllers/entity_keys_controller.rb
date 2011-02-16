class EntityKeysController < ApplicationController
  # GET /entity_keys
  # GET /entity_keys.xml
  def index
    @entity_keys = EntityKey.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @entity_keys }
    end
  end

  # GET /entity_keys/1
  # GET /entity_keys/1.xml
  def show
    @entity_key = EntityKey.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @entity_key }
    end
  end

  # GET /entity_keys/new
  # GET /entity_keys/new.xml
  def new
    @entity_key = EntityKey.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @entity_key }
    end
  end

  # GET /entity_keys/1/edit
  def edit
    @entity_key = EntityKey.find(params[:id])
  end

  # POST /entity_keys
  # POST /entity_keys.xml
  def create
    @entity_key = EntityKey.new(params[:entity_key])

    respond_to do |format|
      if @entity_key.save
        format.html { redirect_to(@entity_key, :notice => 'Entity key was successfully created.') }
        format.xml  { render :xml => @entity_key, :status => :created, :location => @entity_key }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @entity_key.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /entity_keys/1
  # PUT /entity_keys/1.xml
  def update
    @entity_key = EntityKey.find(params[:id])

    respond_to do |format|
      if @entity_key.update_attributes(params[:entity_key])
        format.html { redirect_to(@entity_key, :notice => 'Entity key was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @entity_key.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /entity_keys/1
  # DELETE /entity_keys/1.xml
  def destroy
    @entity_key = EntityKey.find(params[:id])
    @entity_key.destroy

    respond_to do |format|
      format.html { redirect_to(entity_keys_url) }
      format.xml  { head :ok }
    end
  end
end
