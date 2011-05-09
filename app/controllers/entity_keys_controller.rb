class EntityKeysController < ApplicationController
  load_and_authorize_resource

  # GET /entity_keys
  # GET /entity_keys.xml
  def index
    @entity_keys = EntityKey.order('id').page(params[:page])
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @entity_keys }
    end
  end

  # GET /entity_keys/new
  # GET /entity_keys/new.xml
  def new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @entity_key }
    end
  end

  # GET /entity_keys/1/edit
  def edit
  end

  # POST /entity_keys
  # POST /entity_keys.xml
  def create
    respond_to do |format|
      if @entity_key.save
        format.html { redirect_to(entity_keys_path, :notice => "Entity Key was successfully created. #{undo_link}") }
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
    respond_to do |format|
      if @entity_key.update_attributes(params[:entity_key])
        format.html { redirect_to(entity_keys_path, :notice => "Entity Key was successfully updated. #{undo_link}") }
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
    @entity_key.destroy

    respond_to do |format|
      format.html { redirect_to(entity_keys_url, :notice => "Entity Key was successfully deleted. #{undo_link}") }
      format.xml  { head :ok }
    end
  end
  
  ##########
  # PRIVATE
  ##########
  private

    def undo_link
      view_context.link_to("Undo?", revert_version_path(@entity_key.versions.scoped.last), :method => :post)
    end
  
  
end