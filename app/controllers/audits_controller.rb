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

end
