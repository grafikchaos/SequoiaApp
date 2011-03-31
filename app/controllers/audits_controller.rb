class AuditsController < ApplicationController
  load_and_authorize_resource

  # GET /audits
  # GET /audits.xml
  def index
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @audits }
    end
  end

end
