require 'spec_helper'

describe UsersController do
  
  include Devise::TestHelpers
  
  render_views
  
  before(:each) do
    user_role  = Factory(:role, :name => 'User')
    admin_role = Factory(:role, :name => 'Admin')
    @user  = Factory(:user, :roles => [user_role])
    @admin = Factory(:user, :roles => [user_role, admin_role], :email => 'admin@test.com')
  end
  
  describe "unauthorized_user" do
    before(:each) do    
      # Log the regular user in to check that access is blocked.
      request.env['warden'] = mock(Warden, :authenticate => @user,
                                           :authenticate? => @user)
    end
    
    describe "GET 'index'" do
      it "should redirect to the home page" do
        get :index
        response.should redirect_to(root_path)
      end

      it "should have a flash.now message" do
        get :index
        flash.now[:error].should =~ /not authorized/i
      end
    end
    
    describe "GET 'new'" do
      it "should redirect to the home page" do
        get :new
        response.should redirect_to(root_path)
      end

      it "should have a flash.now message" do
        get :new
        flash.now[:error].should =~ /not authorized/i
      end
    end
    
    describe "GET 'show'" do
      it "should redirect to the home page" do
        get :show, :id => @user
        response.should redirect_to(root_path)
      end

      it "should have a flash.now message" do
        get :show, :id => @user
        flash.now[:error].should =~ /not authorized/i
      end
    end
    
    describe "GET 'edit'" do
      it "should redirect to the home page" do
        get :edit, :id => @user
        response.should redirect_to(root_path)
      end

      it "should have a flash.now message" do
        get :edit, :id => @user
        flash.now[:error].should =~ /not authorized/i
      end
    end
  end
  
  
  describe "authorized_user" do
    before(:each) do    
      # Log the admin user in to check that access is allowed.
      request.env['warden'] = mock(Warden, :authenticate => @admin,
                                           :authenticate? => @admin)
    end
    
    describe "GET 'index'" do
      it "should be successful" do
        get :index
        response.should be_success
      end
    
      it "should have the correct title" do
        get :index
        response.should have_selector("title", :content => I18n.t('users.title_index'))
      end    
    end

    describe "GET 'new'" do
      it "should be successful" do
        get :new
        response.should be_success
      end
    
      it "should have the correct title" do
        get :new
        response.should have_selector("title", :content => I18n.t('users.title_new'))
      end   
    end

    describe "GET 'show'" do
      it "should be successful" do
        get :show, :id => @user
        response.should be_success
      end
    
      it "should have the correct title" do
        get :show, :id => @user
        response.should have_selector("title", :content => I18n.t('users.title_show'))
      end  
    end

    describe "GET 'edit'" do
      it "should be successful" do
        get :edit, :id => @user
        response.should be_success
      end
    
      it "should have the correct title" do
        get :edit , :id => @user
        response.should have_selector("title", :content => I18n.t('users.title_edit'))
      end  
    end
  end

end
