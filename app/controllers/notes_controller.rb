class NotesController < ApplicationController

  # GET /audits
  # GET /audits.xml
  def index
    @client = Client.find(params[:client_id])
    @notes = Note.find_all_by_notable_id_and_notable_type(@client.id, 'Client') || []

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @audits }
    end
  end

  def create
    @audit = Audit.new(params[:audit])
    @audit[:user_id] = current_user.id

    respond_to do |format|
      if @audit.save
        format.js { render :json => @audit }
      else
        format.js { render :json => 'Failed' }
      end
    end

  end

end
