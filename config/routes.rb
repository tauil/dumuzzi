Dumuzzi::Application.routes.draw do
  match '/auth/:provider/callback' => 'authentications#create'
  devise_for :users, :controllers => {:registrations => 'registrations'}
  resources :authentications

  root :to => "home#index"
end
