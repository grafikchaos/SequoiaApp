class EntityKeysController < ApplicationController
  load_and_authorize_resource

  # GET /entity_keys
  # GET /entity_keys.xml
  def index
    @entity_keys = EntityKey.order('id').page(params[:page])
    
    respond_to do |format|
      format.html # index.html.erb
    end
  end

  # GET /entity_keys/new
  # GET /entity_keys/new.xml
  def new
    respond_to do |format|
      format.html # new.html.erb
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
      else
        format.html { render :action => "new" }
      end
    end
  end

  # PUT /entity_keys/1
  # PUT /entity_keys/1.xml
  def update
    respond_to do |format|
      if @entity_key.update_attributes(params[:entity_key])
        format.html { redirect_to(entity_keys_path, :notice => "Entity Key was successfully updated. #{undo_link}") }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  # DELETE /entity_keys/1
  # DELETE /entity_keys/1.xml
  def destroy
    @entity_key.destroy

    respond_to do |format|
      format.html { redirect_to(entity_keys_url, :notice => "Entity Key was successfully deleted. #{undo_link}") }
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
