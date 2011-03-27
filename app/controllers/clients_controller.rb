class ClientsController < ApplicationController
  
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

    
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @client }
    end
  end

  # GET /clients/1/edit
  def edit
    @client = Client.find(params[:id])
    1.times { @client.notes.build } if @client.notes.empty?
  end

  # POST /clients
  # POST /clients.xml
  def create
    @client = Client.new(params[:client])
    
    respond_to do |format|
      if @client.save
        format.html { redirect_to(@client, :notice => 'Client was successfully created.') }
        format.xml  { render :xml => @client, :status => :created, :location => @client }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @client.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /clients/1
  # PUT /clients/1.xml
  def update
    @client = Client.find(params[:id])

    respond_to do |format|
      if @client.update_attributes(params[:client])
        format.html { redirect_to(@client, :notice => 'Client was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @client.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /clients/1
  # DELETE /clients/1.xml
  def destroy
    @client = Client.find(params[:id])
    @client.destroy

    respond_to do |format|
      format.html { redirect_to(search_results_url) }
      format.xml  { head :ok }
    end
  end
end
