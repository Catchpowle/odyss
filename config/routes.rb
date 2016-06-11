Rails.application.routes.draw do
  root to: 'groups#index'

  resources :users, except: [:create]
  resources :groups
  resources :memberships, only: [:create, :destroy]

  get '/auth/slack/callback', to: 'users#create'
  get '/auth/:provider/callback', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
end
