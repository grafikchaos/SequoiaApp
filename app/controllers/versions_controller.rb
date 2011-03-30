class VersionsController < ApplicationController

  def revert
    @version = Version.find(params[:id])
    if @version.reify
      if @version.item_type == 'User'
        @version.reify.save(false) # avoid running validations on a user as we have no clue what the original password was
      else
        @version.reify.save!
      end
    else
      @version.item.destroy
    end
    
    link_name = params[:redo] == "true" ? "undo" : "redo"
    link = view_context.link_to(link_name, revert_version_path(@version.next, :redo => !params[:redo]), :method => :post)
    redirect_to :back, :notice => "Undid #{@version.event} for #{@version.item_type}. #{link}"
  end

end
