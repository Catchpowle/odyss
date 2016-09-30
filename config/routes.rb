Rails.application.routes.draw do
  root to: 'groups#index'

  resources :users, except: [:create]
  resources :groups do
    get :invite, on: :member
  end
  resources :memberships, only: [:create, :destroy]

  get '/auth/discord/callback', to: 'users#create'
  get '/auth/:provider/callback', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  match '*path', to: 'application#routing_error', via: :all
end
