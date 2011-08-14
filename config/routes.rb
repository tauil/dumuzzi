Dumuzzi::Application.routes.draw do
  resources :protocols

  resources :queueds

  resources :state_changes

  resources :hosts_services do
    member do
      get 'manual_test'
      get 'threads_test'
    end
  end

  resources :services

  resources :hosts

  resources :domains

  match '/terms' => 'static_pages#terms'

  match '/auth/:provider/callback' => 'authentications#create'
  devise_for :users, :controllers => {:registrations => 'registrations'}
  resources :authentications

  root :to => "home#index"
end
