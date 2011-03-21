class SearchController < ApplicationController

  def start
    respond_to do |format|
      format.html # start.html.erb
    end
  end

  def results
    @results = []
    unless params[:query].blank?
      search = Search.new(params[:query], params[:model])
      @results = search.result
      @query_string = QueryString.find_by_string(params[:query])
    end

    respond_to do |format|
      format.html # results.html.erb
    end
  end

end
