RecursiveRailsStarter::Application.routes.draw do
  
  resources :users

  devise_for :users, :path => '/account'

  get 'pages/home'
  get 'pages/contact'
  get 'pages/about'
  
  match '/contact', :to => 'pages#contact'
  match '/about',   :to => 'pages#about'
  
  root :to => 'pages#home'
  
end
