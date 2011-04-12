class AuditsController < ApplicationController

  # GET /audits
  # GET /audits.xml
  def index
    @audits = params[:search] ? Audit.message_contains?(params[:search]) : Audit.all
    authorize! :read, Audit

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
