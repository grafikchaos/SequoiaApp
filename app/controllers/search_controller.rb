class SearchController < ApplicationController
  def index
    if params[:query]
      search = Search.new(params[:query], params[:model])
      @results = search.result
    end

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @objects }
    end
  end
end
