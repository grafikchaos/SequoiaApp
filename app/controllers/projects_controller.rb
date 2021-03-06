class ProjectsController < ApplicationController
  # GET /projects
  # GET /projects.xml
  def index
    @client = Client.find(params[:client_id])
    @projects = @client.projects.all 

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  # GET /projects/new
  # GET /projects/new.xml
  def new
    @client = Client.find(params[:client_id])
    @project = Project.new
    
    1.times { @project.notes.build }

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # GET /projects/1/edit
  def edit
    @project = Project.find(params[:id])
    1.times { @project.notes.build } if @project.notes.empty?
  end

  # POST /projects
  # POST /projects.xml
  def create
    @client   = Client.find(params[:client_id])
    @project  = @client.projects.build(params[:project])

    respond_to do |format|
      if @project.save
        format.html { redirect_to(@client, :notice => "Project was successfully created. #{undo_link}") }
      else
        format.html { render :action => "new" }
      end
    end
  end

  # PUT /projects/1
  # PUT /projects/1.xml
  def update
    @project = Project.find(params[:id])

    respond_to do |format|
      if @project.update_attributes(params[:project])
        format.html { redirect_to(@project.client, :notice => "Project was successfully updated. #{undo_link}") }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.xml
  def destroy
    @project = Project.find(params[:id])
    @project.destroy

    respond_to do |format|
      format.html { redirect_to(client_projects_url(@project.client), :notice => "Project was successfully destroyed. #{undo_link}") }
    end
  end
  
  ##########
  # PRIVATE
  ##########
  private

    def undo_link
      view_context.link_to("Undo?", revert_version_path(@project.versions.scoped.last), :method => :post)
    end
  
  
end
