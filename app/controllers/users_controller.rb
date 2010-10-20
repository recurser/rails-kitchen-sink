# Handles CRUD for user administration.
class UsersController < ApplicationController
  
  # Make the current user only accessible to certain actions.
  before_filter :get_user, :only => [:index, :new, :edit]
  
  # Populate the list of :accessible_roles for certain actions.
  before_filter :accessible_roles, :only => [:new, :edit, :update, :create]
  
  # Protect with CanCan.
  load_and_authorize_resource
  
  # Displays a paginated list of all users in the ysytem.
  def index
    @users = User.accessible_by(current_ability, :index).paginate(:page => params[:page])
    respond_to do |format|
      format.json { render :json => @users }
      format.xml  { render :xml => @users }
      format.html
    end
  end
  
  # Displays a blank form for creating a new user.
  def new
    respond_to do |format|
      format.json { render :json => @user }   
      format.xml  { render :xml => @user }
      format.html
    end
  end
  
  # Accepts a POST, and creates a new user from the given params if valid.
  def create
    @user = User.new(params[:user])
    
    if @user.save_without_confirmation!
      flash[:notice] = t 'users.flash.user_created', :email => @user.email
      # Can't mass-assign role_ids - want to protect this from regular users.
      @user.role_ids = params[:user][:role_ids]
      
      respond_to do |format|
        format.json { render :json => @user.to_json, :status => 200 }
        format.xml  { head :ok }
        format.html { redirect_to :action => :index }
      end
    else
      respond_to do |format|
        format.json { render :text => "Could not create user", :status => :unprocessable_entity } # placeholder
        format.xml  { head :ok }
        format.html { render :action => :new, :status => :unprocessable_entity }
      end
    end
  end
  
  # Displays details of the specified user.
  def show
    respond_to do |format|
      format.json { render :json => @user }
      format.xml  { render :xml => @user }
      format.html      
    end
  end
  
  # Displays a form to edit the specified user.
  def edit
    respond_to do |format|
      format.json { render :json => @user }   
      format.xml  { render :xml => @user }
      format.html
    end
  end
  
  # Accepts a POST, and updates the specified user with the given params if valid.
  def update
    # Don't try to update the password if none has been provided.
    if params[:user][:password].blank?
      [:password, :password_confirmation].collect{|param| params[:user].delete(param) }
    end
 
    respond_to do |format|
      if @user.errors[:base].empty? and @user.update_attributes(params[:user])
        # Can't mass-assign role_ids - want to protect this from regular users.
        @user.role_ids = params[:user][:role_ids]
      
        flash[:notice] = t 'users.flash.user_updated', :email => @user.email
        format.json { render :json => @user.to_json, :status => 200 }
        format.xml  { head :ok }
        format.html { render :action => :edit }
      else
        format.json { render :text => "Could not update user", :status => :unprocessable_entity }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
        format.html { render :action => :edit, :status => :unprocessable_entity }
      end
    end
  end
  
  # Accepts a POST, and destroys the specified user.
  def destroy
    flash[:notice] = t 'users.flash.user_deleted', :email => @user.email
    @user.destroy
 
    respond_to do |format|
      format.json { redirect_to :action => :index }
      format.xml  { head :ok }
      format.html { redirect_to :action => :index }      
    end
  end

end