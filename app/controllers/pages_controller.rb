# Displays basic static company pages.
class PagesController < ApplicationController
  
  # Site top-page.
  def home
    @title = 'pages.title_home'
  end
  
  # About-this-project page.
  def about
    @title = 'pages.title_about'
  end

end
