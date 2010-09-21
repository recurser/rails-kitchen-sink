RecursiveRailsStarter::Application.routes.draw do
  
  devise_for :users do
    get 'sign_up'     => 'devise/registrations#new' 
    get 'sign_in'     => 'devise/sessions#new'    
    get 'sign_out'    => 'devise/sessions#destroy' 
  end 

  get 'pages/home'
  get 'pages/contact'
  get 'pages/about'
  
  match '/contact', :to => 'pages#contact'
  match '/about',   :to => 'pages#about'
  
  root :to => 'pages#home'
  
  
end
