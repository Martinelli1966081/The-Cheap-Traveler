Rails.application.routes.draw do

  devise_for :users, controllers: {
    registrations: "users/registrations",
    sessions: "users/sessions",
    omniauth_callbacks: "users/omniauth_callbacks"
  }
  post '/users/sign_in', to: 'devise/sessions#create', as: :login

  root "homepage#index"
  get '/users/index', to: 'help#index'
  get '/help', to: 'help#index'
  get '/destinations', to: 'destinations#index'
  get '/stays', to: 'stays#index'
  get '/taxi', to: 'taxis#index'
  get '/attractions', to: 'attractions#index'
  get '/transports', to: 'transports#index'
  get '/wishlists', to: "wishlists#index"
  get '/reservations', to: "reservations#index"
  get '/business', to: "business#index"
  get '/travels', to: "travels#index"
  get '/notifications', to: 'notifications#show'
  
  resources :users do
    member do
      patch 'update_notification_preferences', to: 'notifications#update_notification_preferences'
    end
  end

  post 'newsletter/subscribe', to: 'newsletter#subscribe', as: :newsletter_subscribe

  resources :business, only: [] do
    collection do
      post :request_upgrade
      get :confirm_upgrade, path: 'confirm_upgrade' 
      post :complete_upgrade
    end
  end
  
  post 'newsletter_subscriptions', to: 'newsletter_subscriptions#create'

  resources :travels, only: [:index, :create] do 
    post "join", on: :member
  end
  resources :taxis, only: [:index, :create, :destroy]
  resources :stays, only: [:index, :show, :edit, :update] do
    collection do
      get 'business' => 'business#index', as: :business
      post 'business' => 'business#create_stay'
    end
    member do
      delete 'business/:id' => 'business#destroy_stay', as: :business_destroy
    end
    post 'add_to_wishlist', to: 'wishlists#create', as: 'add_to_wishlist'
  end
  resources :attractions, only: [:index, :show]
  resources :destinations, only: [:index, :show]
  resources :transports, only: [:index, :show]
  resources :reservations, only: [:index, :new, :create, :destroy]
  resources :wishlists, only: [:index] do
    delete 'remove_from_wishlist', to: 'wishlists#destroy', as: 'remove_from_wishlist'
  end

  get "up" => "rails/health#show", as: :rails_health_check
  
end
