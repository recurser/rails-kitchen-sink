class PagesController < ApplicationController
  
  def home
    @title = 'pages.title_home'
  end

  def contact
    @title = 'pages.title_contact'
  end

  def about
    @title = 'pages.title_about'
  end

end
