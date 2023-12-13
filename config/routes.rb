Rails.application.routes.draw do
  
  post "oauth/callback" => "oauths#callback"
  get "oauth/callback" => "oauths#callback" 
  get "oauth/:provider" => "oauths#oauth", :as => :auth_at_provider

  root "static_pages#top"
  resources :users, only: %i[new create]
  resources :sessions, only: [:new, :create, :destroy]

  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'
end
