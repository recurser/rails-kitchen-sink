require 'spec_helper'

describe "LayoutLinks" do

  it "should have a Home page at '/'" do
    get '/'
    response.should have_selector('title', :content => I18n.t('pages.title_home'))
  end

  it "should have a Contact page at '/contact'" do
    get '/contact'
    response.should have_selector('title', :content => I18n.t('pages.title_contact'))
  end

  it "should have an About page at '/about'" do
    get '/about'
    response.should have_selector('title', :content => I18n.t('common.title_prefix'))
  end

  it "should have a Login page at '/account/sign_in'" do
    get '/account/sign_in'
    response.should have_selector('title', :content => I18n.t('common.title_prefix'))
  end
  
end