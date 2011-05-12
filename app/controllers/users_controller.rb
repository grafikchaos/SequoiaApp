class UsersController < ApplicationController
  load_and_authorize_resource :except => [:edit, :update, :unlock]

  # GET /users
  # GET /users.xml
  def index
    @users = User.order('id').page(params[:page])
    
    respond_to do |format|
      format.html # index.html.erb
    end
  end

  # GET /users/new
  # GET /users/new.xml
  def new
    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id] || current_user.id)
    authorize! :update, @user

    respond_to do |format|
      format.html # edit.html.erb
    end
  end

  # POST /users
  # POST /users.xml
  def create
    respond_to do |format|
      if @user.save
        format.html { redirect_to(users_url, :notice => "User was successfully created. #{undo_link}") }
      else
        format.html { render :action => "new" }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.xml
  def update
    @user = User.find(params[:id] || current_user.id)
    authorize! :update, @user

    # Unset the stuff the user does not have permission to edit
    params[:user][:role_ids] ||= []
    params[:user].delete(:role_ids) if cannot? :assign_roles, User
    if params[:user][:password].blank?
      [:password, :password_confirmation].collect{ |p| params[:user].delete(p) }
    end    

    respond_to do |format|
      if @user.update_attributes(params[:user])
        if current_user.id == @user.id && current_user.has_role?('staff')
          format.html { redirect_to(edit_user_url(@user), :notice => "Your account was successfully updated. #{undo_link}") }
        else
          format.html { redirect_to(users_url, :notice => "User was successfully updated. #{undo_link}") }
        end
      else
        format.html { render :action => "edit" }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.xml
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to(users_url, :notice => "User was successfully destroyed. #{undo_link}") }
    end
  end

  # Break the lock on users.
  def unlock
    user = User.find(params[:user_id])
    authorize! :update, user
    user.unlock_access!

    respond_to do |format|
      if user.active_for_authentication?
        format.html { redirect_to(users_url, :notice => 'User account has been unlocked.') }
      else
        format.html { redirect_to(users_url, :alert => 'User account was not unlocked.') }
      end
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
