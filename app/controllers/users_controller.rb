class UsersController < ApplicationController
  
  load_and_authorize_resource
  
  def index
    @title = 'users.title_index'
    @users = User.paginate(:page => params[:page])
  end

  def new
    @title = 'users.title_new'
  end

  def create
    @title = 'users.title_create'
  end

  def show
    @title = 'users.title_show'
  end

  def edit
    @title = 'users.title_edit'
  end

  def update
    @title = 'users.title_update'
  end

  def destroy
    @title = 'users.title_destroy'
  end

end
