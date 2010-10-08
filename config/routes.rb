RecursiveRailsStarter::Application.routes.draw do
  
  resources :contacts, :only => [:new, :create]

  resources :users

  devise_for :users, :path => '/account'

  get 'pages/home'
  get 'pages/about'
  
  match '/contact', :to => 'contacts#new'
  match '/about',   :to => 'pages#about'
  
  root :to => 'pages#home'
  
end
