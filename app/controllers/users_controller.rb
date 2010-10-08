class UsersController < ApplicationController
  
  before_filter :get_user, :only => [:index, :new, :edit]
  before_filter :accessible_roles, :only => [:new, :edit, :show, :update, :create]
  
  load_and_authorize_resource
  
 
  def index
    @title = 'users.title_index'
    @users = User.accessible_by(current_ability, :index).paginate(:page => params[:page])
    respond_to do |format|
      format.json { render :json => @users }
      format.xml  { render :xml => @users }
      format.html
    end
  end
  
  
  def new
    @title = 'users.title_new'
    respond_to do |format|
      format.json { render :json => @user }   
      format.xml  { render :xml => @user }
      format.html
    end
  end
  
  
  def create
    @title = 'users.title_create'
    @user = User.new(params[:user])
    
    # Don't want to sent any confirmation messages.
    @user.skip_confirmation!
    
    if @user.save
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
  
  
  def show
    @title = 'users.title_show'
    respond_to do |format|
      format.json { render :json => @user }
      format.xml  { render :xml => @user }
      format.html      
    end
  end
  
  
  def edit
    @title = 'users.title_edit'
    respond_to do |format|
      format.json { render :json => @user }   
      format.xml  { render :xml => @user }
      format.html
    end
  end
  
  
  def update
    # Don't try to update the password if none has been provided.
    if params[:user][:password].blank?
      [:password, :password_confirmation].collect{|p| params[:user].delete(p) }
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
  
  
  def destroy
    @title = 'users.title_destroy'
    flash[:notice] = t 'users.flash.user_deleted', :email => @user.email
    @user.destroy
 
    respond_to do |format|
      format.json { redirect_to :action => :index }
      format.xml  { head :ok }
      format.html { redirect_to :action => :index }      
    end
  end
  
end