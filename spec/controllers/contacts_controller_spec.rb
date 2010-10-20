require 'spec_helper'

describe ContactsController do
  
  include Devise::TestHelpers
  
  render_views

  describe 'GET *new*' do
    
    it 'should be successful' do
      get :new
      response.should be_success
    end
    
    it 'should have the correct title' do
      get :new
      response.should have_selector('title', :content => I18n.t('contacts.new.title'))
    end    
    
  end
    
  describe 'POST *create*' do
    
    describe 'with invalid parameters' do
      
      before(:each) do
        @attr = {:email => '', :subject => '', :body => ''}
      end
      
      it 'should render the *new* page' do
        post :create, :contact => @attr
        response.should render_template('new')
      end

      it 'should have a flash.now message' do
        post :create, :contact => @attr
        msg = I18n.t('contacts.flash.invalid_form_warning')
        flash.now[:alert].should == msg
      end
      
    end
    
    describe 'with valid parameters' do
      
      before(:each) do
        @attr = {
          :email   => 'railskitchensink@recursive-design.com',
          :subject => 'Urgent Problem',
          :body    => 'Please reply ASAP!'
        }
      end

      it 'should redirect to the top page' do
        post :create, :contact => @attr
        response.should redirect_to(root_path)
      end

      it 'should have a flash.now message' do
        post :create, :contact => @attr
        msg = I18n.t('contacts.flash.message_sent')
        flash.now[:notice].should == msg
      end
      
    end
    
  end

end
