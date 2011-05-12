class FavoritesController < ApplicationController
  load_and_authorize_resource :except => [:index, :create]

  # GET /favorites
  # GET /favorites.xml
  def index
    @favorites = Favorite.find_all_by_user_id(current_user.id)

    respond_to do |format|
      format.js { render :partial => 'sidebar' }
      format.html # index.html.erb
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
    fav = params[:favorite]
    fav[:user_id] = current_user.id
    fav[:name] = fav[:note]
    @favorite = Favorite.new(fav)
    @favorite.save
    render 'toggle'
  end

  # PUT /favorites/1
  # PUT /favorites/1.xml
  def update
    respond_to do |format|
      if @favorite.update_attributes(params[:favorite])
        format.html { redirect_to(favorites_path, :notice => 'Favorite was successfully updated.') }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  # DELETE /favorites/1
  # DELETE /favorites/1.xml
  def destroy
    @favorite.destroy

    respond_to do |format|
      format.js { render 'toggle' }
      format.html { redirect_to(favorites_path, :notice => 'Favorite was successfully deleted.') }
    end
  end
end
