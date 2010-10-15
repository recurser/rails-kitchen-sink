RecursiveRailsStarter::Application.routes.draw do

  scope '(:locale)', :locale => /en|fr/ do
    resources :contacts, :only => [:new, :create]
    resources  :users
    devise_for :users, :path => '/account'

    match '/:locale/contact', :to => 'contacts#new'
    match '/contact',         :to => 'contacts#new'
  
    match '/:locale/about',   :to => 'pages#about'
    match '/about',           :to => 'pages#about'
  
    match '/:locale' => 'pages#home'
    root :to => 'pages#home'
  end
  
end
