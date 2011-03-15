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
  end

  # GET /favorites/1/edit
  def edit
  end

  # POST /favorites
  # POST /favorites.xml
  def create
    @favorite.save
    render 'toggle'
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
    render 'toggle'
  end
end
