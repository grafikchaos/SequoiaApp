class FavoritesController < ApplicationController
  load_and_authorize_resource

  # GET /favorites
  # GET /favorites.xml
  def index
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @favorites }
    end
  end

  # GET /favorites/new
  # GET /favorites/new.xml
  def new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @favorite }
    end
  end

  # GET /favorites/1/edit
  def edit
  end

  # POST /favorites
  # POST /favorites.xml
  def create
    respond_to do |format|
      if @favorite.save
        format.html { redirect_to(@favorite, :notice => 'Favorite was successfully created.') }
        format.xml  { render :xml => @favorite, :status => :created, :location => @favorite }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @favorite.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /favorites/1
  # PUT /favorites/1.xml
  def update
    respond_to do |format|
      if @favorite.update_attributes(params[:favorite])
        format.html { redirect_to(@favorite, :notice => 'Favorite was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @favorite.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /favorites/1
  # DELETE /favorites/1.xml
  def destroy
    @favorite.destroy

    respond_to do |format|
      format.html { redirect_to(favorites_url) }
      format.xml  { head :ok }
    end
  end
end
