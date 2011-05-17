class RolesController < ApplicationController
  load_and_authorize_resource

  # GET /roles
  # GET /roles.xml
  def index
    @roles = Role.order('id').page(params[:page])
    
    respond_to do |format|
      format.html # index.html.erb
    end
  end

  # GET /roles/new
  # GET /roles/new.xml
  def new
    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # GET /roles/1/edit
  def edit
  end

  # POST /roles
  # POST /roles.xml
  def create
    respond_to do |format|
      if @role.save
        format.html { redirect_to(roles_url, :notice => 'Role was successfully created.') }
      else
        format.html { render :action => "new" }
      end
    end
  end

  # PUT /roles/1
  # PUT /roles/1.xml
  def update
    respond_to do |format|
      if @role.update_attributes(params[:role])
        format.html { redirect_to(roles_url, :notice => 'Role was successfully updated.') }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  # DELETE /roles/1
  # DELETE /roles/1.xml
  def destroy
    @role.destroy

    respond_to do |format|
      format.html { redirect_to(roles_url) }
    end
  end
end
