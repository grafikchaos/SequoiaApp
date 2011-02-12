class ProjectsController < ApplicationController
  # GET /projects
  # GET /projects.xml
  def index
    @client = Client.find(params[:client_id])
    @projects = @client.projects.all 

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @projects }
    end
  end

  # GET /projects/1
  # GET /projects/1.xml
  def show
    @client = Client.find(params[:client_id])
    @project = @client.projects.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @project }
    end
  end

  # GET /projects/new
  # GET /projects/new.xml
  def new
    @client = Client.find(params[:client_id])
    @project = Project.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @project }
    end
  end

  # GET /projects/1/edit
  def edit
    @client = Client.find(params[:client_id])
    @project = @client.projects.find(params[:id])
  end

  # POST /projects
  # POST /projects.xml
  def create
    @client   = Client.find(params[:client_id])
    @project  = @client.projects.build(params[:project])

    respond_to do |format|
      if @project.save
        format.html { redirect_to(client_projects_url(@client), :notice => 'Project was successfully created.') }
        format.xml  { render :xml => @project, :status => :created, :location => @project }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @project.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /projects/1
  # PUT /projects/1.xml
  def update
    @client = Client.find(params[:client_id])
    @project = @client.projects.find(params[:id])

    respond_to do |format|
      if @project.update_attributes(params[:project])
        format.html { redirect_to(client_projects_url(@client), :notice => 'Project was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @project.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.xml
  def destroy
    @client = Client.find(params[:client_id])
    @project = @client.projects.find(params[:id])
    @project.destroy

    respond_to do |format|
      format.html { redirect_to(client_projects_url) }
      format.xml  { head :ok }
    end
  end
end
