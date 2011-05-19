class UsersController < ApplicationController
  load_and_authorize_resource :except => [:edit, :update, :unlock]

  # Define which formats actions are able to respond with
  respond_to :html

  # GET /users
  def index
    @users = User.order('id').page(params[:page])
    respond_with @users
  end

  # GET /users/new
  def new
    respond_with @user
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id] || current_user.id)
    authorize! :update, @user
    respond_with @user
  end

  # POST /users
  def create
    if @user.save
      respond_with(@user, :notice => "User was successfully created. #{undo_link}", :location => users_url )
    else
      render "new"
    end
  end

  # PUT /users/1
  def update
    @user = User.find(params[:id] || current_user.id)
    authorize! :update, @user

    # Unset the stuff the user does not have permission to edit
    params[:user][:role_ids] ||= []
    params[:user].delete(:role_ids) if cannot? :assign_roles, User
    if params[:user][:password].blank?
      [:password, :password_confirmation].collect{ |p| params[:user].delete(p) }
    end    

    if @user.update_attributes(params[:user])
      if current_user.id == @user.id && current_user.has_role?('staff')
        respond_with(@user, :notice => "Your account was successfully updated. #{undo_link}", :location => edit_user_url(@user) )
      else
        respond_with(@user, :notice => "User was successfully updated. #{undo_link}", :location => users_url )
      end
    else
      render "edit"
    end
  end

  # DELETE /users/1
  # DELETE /users/1.xml
  def destroy
    @user.destroy
    respond_with( @user, :notice => "User was successfully destroyed. #{undo_link}", :location => users_url )
  end

  # Break the lock on users.
  def unlock
    user = User.find(params[:user_id])
    authorize! :update, user
    user.unlock_access!

    if user.active_for_authentication?
      respond_with( @user, :notice => "User account has been unlocked.", :location => users_url )
    else
      respond_with( @user, :notice => "User account was not unlocked", :location => users_url )
    end
  end
  
  
  ##########
  # PRIVATE
  ##########
  private

  def undo_link
    view_context.link_to("Undo?", revert_version_path(@user.versions.scoped.last), :method => :post)
  end

end
