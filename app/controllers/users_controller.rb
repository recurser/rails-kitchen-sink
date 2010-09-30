class UsersController < ApplicationController
  before_filter :get_user, :only => [:index,:new,:edit]
  before_filter :accessible_roles, :only => [:new, :edit, :show, :update, :create]
  load_and_authorize_resource :only => [:show,:new,:destroy,:edit,:update]
 
  # GET /users
  # GET /users.xml                                                
  # GET /users.json                                       HTML and AJAX
  #-----------------------------------------------------------------------
  def index
    @title = 'users.title_index'
    @users = User.accessible_by(current_ability, :index).paginate(:page => params[:page])
    respond_to do |format|
      format.json { render :json => @users }
      format.xml  { render :xml => @users }
      format.html
    end
  end
 
  # GET /users/new
  # GET /users/new.xml                                            
  # GET /users/new.json                                    HTML AND AJAX
  #-------------------------------------------------------------------
  def new
    @title = 'users.title_new'
    respond_to do |format|
      format.json { render :json => @user }   
      format.xml  { render :xml => @user }
      format.html
    end
  end
 
  # GET /users/1
  # GET /users/1.xml                                                       
  # GET /users/1.json                                     HTML AND AJAX
  #-------------------------------------------------------------------
  def show
    @title = 'users.title_show'
    respond_to do |format|
      format.json { render :json => @user }
      format.xml  { render :xml => @user }
      format.html      
    end
 
  rescue ActiveRecord::RecordNotFound
    respond_to_not_found(:json, :xml, :html)
  end
 
  # GET /users/1/edit                                                      
  # GET /users/1/edit.xml                                                      
  # GET /users/1/edit.json                                HTML AND AJAX
  #-------------------------------------------------------------------
  def edit
    @title = 'users.title_edit'
    respond_to do |format|
      format.json { render :json => @user }   
      format.xml  { render :xml => @user }
      format.html
    end
 
  rescue ActiveRecord::RecordNotFound
    respond_to_not_found(:json, :xml, :html)
  end
 
  # DELETE /users/1     
  # DELETE /users/1.xml
  # DELETE /users/1.json                                  HTML AND AJAX
  #-------------------------------------------------------------------
  def destroy
    @title = 'users.title_destroy'
    @user.destroy!
 
    respond_to do |format|
      format.json { respond_to_destroy(:ajax) }
      format.xml  { head :ok }
      format.html { respond_to_destroy(:html) }      
    end
 
  rescue ActiveRecord::RecordNotFound
    respond_to_not_found(:json, :xml, :html)
  end
 
  # POST /users
  # POST /users.xml         
  # POST /users.json                                      HTML AND AJAX
  #-----------------------------------------------------------------
  def create
    @title = 'users.title_create'
    @user = User.new(params[:user])
 
    if @user.save
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
  
end