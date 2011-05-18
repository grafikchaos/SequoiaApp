class ClientsController < ApplicationController
  respond_to :html
  
  # Just redirects to the clients entity index page.
  # The action is here so that we can keep the flash messages.
  def show
    flash.keep
    redirect_to client_entities_path(:client_id => params[:id])
  end

  # GET /clients/new
  # GET /clients/new.xml
  def new
    @client = Client.new
    1.times { @client.projects.build }
    1.times { @client.notes.build }
    respond_with(@client)
  end

  # GET /clients/1/edit
  def edit
    @client = Client.find(params[:id])
    1.times { @client.notes.build } if @client.notes.empty?
    respond_with(@client)
  end

  # POST /clients
  # POST /clients.xml
  def create
    @client = Client.new(params[:client])
    
    respond_to do |format|
      if @client.save
        format.html { redirect_to(@client, :notice => "Client was successfully created. #{undo_link}") }
      end
      respond_with(@client)
    end
  end

  # PUT /clients/1
  # PUT /clients/1.xml
  def update
    @client = Client.find(params[:id])

    respond_to do |format|
      if @client.update_attributes(params[:client])
        format.html { redirect_to(@client, :notice => "Client was successfully updated. #{undo_link}") }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  # DELETE /clients/1
  # DELETE /clients/1.xml
  def destroy
    @client = Client.find(params[:id])
    @client.destroy

    respond_to do |format|
      format.html { redirect_to(search_results_url, :notice => "Client was successfully destroyed. #{undo_link}") }
    end
  end
  
  
  ##########
  # PRIVATE
  ##########
  private

    def undo_link
      view_context.link_to("Undo?", revert_version_path(@client.versions.scoped.last), :method => :post)
    end
  
  
end
