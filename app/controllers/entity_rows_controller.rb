class EntityRowsController < ApplicationController

  # GET /entity_rows/new
  # GET /entity_rows/new.xml
  def new
    @entity_row = EntityRow.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @entity_row }
    end
  end

  # GET /entity_rows/1/edit
  def edit
    @entity_row = EntityRow.find(params[:id])
  end

  # POST /entity_rows
  # POST /entity_rows.xml
  def create
    @entity_row = EntityRow.new(params[:entity_row])

    respond_to do |format|
      if @entity_row.save
        format.html { redirect_to(@entity_row, :notice => 'Entity row was successfully created.') }
        format.xml  { render :xml => @entity_row, :status => :created, :location => @entity_row }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @entity_row.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /entity_rows/1
  # PUT /entity_rows/1.xml
  def update
    @entity_row = EntityRow.find(params[:id])

    respond_to do |format|
      if @entity_row.update_attributes(params[:entity_row])
        format.html { redirect_to(@entity_row, :notice => 'Entity row was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @entity_row.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /entity_rows/1
  # DELETE /entity_rows/1.xml
  def destroy
    @entity_row = EntityRow.find(params[:id])
    @entity_row.destroy

    respond_to do |format|
      format.html { redirect_to(entity_rows_url) }
      format.xml  { head :ok }
    end
  end
end
