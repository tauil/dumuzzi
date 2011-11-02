Dumuzzi::Application.routes.draw do
  resources :protocols
  resources :queueds
  resources :state_changes
  resources :hosts_services do
    member do
      get :manual_test
      get :threads_test
    end
  end
  resources :services
  resources :hosts
  
  resources :domains do
    collection do
      post :monitored
    end
  end

  match '/terms' => 'static_pages#terms'
  match '/about' => 'static_pages#about'
  
  match '/signup' => 'users#new'
  resources :users
  
  match '/signin' => 'user_sessions#new'
  match '/signout' => 'user_sessions#destroy'
  resources :user_sessions
  
  match '/auth/:provider/callback' => 'authentications#create'
  match "/auth/failure" => 'authentications#failure'
  match "/auth/:provider" => 'authentications#blank'
  resources :authentications

  root :to => "home#index"
end
