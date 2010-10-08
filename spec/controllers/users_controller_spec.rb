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
  
  describe "Un-authorized user" do
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
  
  
  describe "Authorized user" do
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

      it "should render the 'index' page" do
        get :index, :user => @attr
        response.should render_template('index')
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

      it "should render the 'new' page" do
        get :new, :user => @attr
        response.should render_template('new')
      end
    end

    describe "GET 'show'" do
      
      describe "failure" do
        # TODO - not found
      end
      
      describe "success" do
        it "should be successful" do
          get :show, :id => @user
          response.should be_success
        end
  
        it "should have the correct title" do
          get :show, :id => @user
          response.should have_selector("title", :content => I18n.t('users.title_show'))
        end   

        it "should render the 'show' page" do
          get :show, :id => @user
          response.should render_template('show')
        end
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

      it "should render the 'edit' page" do
        get :edit, :id => @user
        response.should render_template('edit')
      end
    end
    
    describe "POST 'create'" do
      
      describe "failure" do
        before(:each) do
          @attr = { :email => "", :password => "", :password_confirmation => "" }
        end

        it "should not create a user" do
          lambda do
            post :create, :user => @attr
          end.should_not change(User, :count)
        end

        it "should render the 'new' page" do
          post :create, :user => @attr
          response.should render_template('new')
        end
      end
      
      describe "success" do
        before(:each) do
          @attr = { :email => "test@recursive-design.com", :password => "123456", :password_confirmation => "123456" }
        end

        it "should create a user" do
          lambda do
            post :create, :user => @attr
          end.should change(User, :count).by(1)
        end

        it "should redirect to the view-all-users page" do
          post :create, :user => @attr
          response.should redirect_to(users_path)
        end

        it "should have a flash.now message" do
          post :create, :user => @attr
          success_msg = I18n.t('users.flash.user_created', :email => @attr[:email])
          flash.now[:notice].should == success_msg
        end
      end
    end
    
    describe "POST 'update'" do
      
      describe "failure" do
        before(:each) do
          @attr = { :email => "", :password => "", :password_confirmation => "" }
        end

        it "should render the 'edit' page" do
          post :update,  :id => @user, :user => @attr
          response.should render_template('edit')
        end

        it "should not update the user" do
          post :update,  :id => @user, :user => @attr
          @user.email.should_not equal @attr[:email]
        end
      end
      
      describe "success" do
        before(:each) do
          @attr = { :email => "test@recursive-design.com", :password => "123456", :password_confirmation => "123456" }
        end

        it "should be successful" do
          post :update,  :id => @user, :user => @attr
          response.should be_success
        end

        it "should have a flash.now message" do
          post :update,  :id => @user, :user => @attr
          success_msg = I18n.t('users.flash.user_updated', :email => @attr[:email])
          flash.now[:notice].should == success_msg
        end
      end
    end
    
    describe "POST 'destroy'" do  
       
      it "should delete a user" do
        lambda do
          post :destroy, :id => @user
        end.should change(User, :count).by(-1)
      end

      it "should redirect to the view-all-users page" do
        post :destroy, :id => @user
        response.should redirect_to(users_path)
      end

      it "should have a flash.now message" do
        post :destroy, :id => @user
        success_msg = I18n.t('users.flash.user_deleted', :email => @user.email)
        flash.now[:notice].should == success_msg
      end
      
    end
  
  
  end

end
