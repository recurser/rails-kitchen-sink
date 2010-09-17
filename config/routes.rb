RecursiveRailsStarter::Application.routes.draw do
  
  get "pages/home"
  get "pages/contact"
  get "pages/about"
  
  match '/contact', :to => 'pages#contact'
  match '/about',   :to => 'pages#about'
  
  root :to => 'pages#home'
  
  
end
