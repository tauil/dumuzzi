Dumuzzi::Application.routes.draw do
  resources :hosts_services

  resources :services

  resources :hosts

  resources :domains

  match '/auth/:provider/callback' => 'authentications#create'
  devise_for :users, :controllers => {:registrations => 'registrations'}
  resources :authentications

  root :to => "home#index"
end
