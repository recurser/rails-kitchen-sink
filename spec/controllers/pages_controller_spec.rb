require 'spec_helper'

describe PagesController do
  
  include Devise::TestHelpers
  
  render_views

  describe 'GET *home*' do
    it 'should be successful' do
      get :home
      response.should be_success
    end
    
    it 'should have the correct title' do
      get :home
      response.should have_selector('title', :content => I18n.t('pages.home.title'))
    end    
  end

  describe 'GET *about*' do
    it 'should be successful' do
      get :about
      response.should be_success
    end
    
    it 'should have the correct title' do
      get :about
      response.should have_selector('title', :content => I18n.t('pages.about.title'))
    end
  end

end
