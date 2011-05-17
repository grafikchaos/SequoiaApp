class EntityTypesController < ApplicationController
  load_and_authorize_resource

  # GET /entity_types
  # GET /entity_types.xml
  def index
    @entity_types = EntityType.order('id').page(params[:page])
    
    respond_to do |format|
      format.html # index.html.erb
    end
  end

  # GET /entity_types/new
  # GET /entity_types/new.xml
  def new
    3.times { @entity_type.entity_type_aliases.build } 
    3.times { @entity_type.form_configs.build }
    
    respond_to do |format|
      format.html # new.html.erb
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
        format.html { redirect_to(entity_types_path, :notice => "Entity Type was successfully created. #{undo_link}") }
      else
        format.html { render :action => "new" }
      end
    end
  end

  # PUT /entity_types/1
  # PUT /entity_types/1.xml
  def update
    respond_to do |format|
      if @entity_type.update_attributes(params[:entity_type])
        format.html { redirect_to(entity_types_path, :notice => "Entity Type was successfully updated. #{undo_link}") }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  # DELETE /entity_types/1
  # DELETE /entity_types/1.xml
  def destroy
    @entity_type.destroy

    respond_to do |format|
      format.html { redirect_to(entity_types_url, :notice => "Entity Type was successfully deleted. #{undo_link}") }
    end
  end
  
  ##########
  # PRIVATE
  ##########
  private

    def undo_link
      view_context.link_to("Undo?", revert_version_path(@entity_type.versions.scoped.last), :method => :post)
    end
  
end
