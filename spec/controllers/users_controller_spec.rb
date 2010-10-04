require 'spec_helper'

describe UsersController do
  
  include Devise::TestHelpers
  
  render_views
  
  before(:each) do
    user_role  = Factory(:role, :name => 'User')
    admin_role = Factory(:role, :name => 'Admin')
    @user  = Factory(:user, :roles => [user_role])
    @admin = Factory(:user, :roles => [user_role, admin_role], :email => 'admin@test.com')
    
    # Log the user in before testing.
    request.env['warden'] = mock(Warden, :authenticate => @admin,
                                         :authenticate? => @admin)
  end

  describe "GET 'index'" do
    it "should be successful" do
      get 'index'
      response.should be_success
    end
  end

  describe "GET 'new'" do
    it "should be successful" do
      get 'new'
      response.should be_success
    end
  end

  describe "GET 'show'" do
    it "should be successful" do
      get :show, :id => @user
      response.should be_success
    end
  end

  describe "GET 'edit'" do
    it "should be successful" do
      get :show, :id => @user
      response.should be_success
    end
  end

end
