require 'sidekiq/web'

Rails.application.routes.draw do
  namespace :api, path: '' do
    post '/api', to: 'graphql#query'
    mount GraphiQL::Rails::Engine, at: '/graphiql', graphql_path: '/api' if Rails.env.development?
  end

  mount Sidekiq::Web => '/sidekiq', constraints: lambda { |request| request.session[:user_id].eql?(1) }

  root to: 'groups#index'

  resources :users, except: [:create] do
    scope module: :users do
      resources :notifications, only: [:index]
    end
  end
  resources :groups do
    scope module: :groups do
      get :invite, to: 'invite#show'
    end
  end
  resources :memberships, only: [:create, :destroy] do
    scope module: :memberships do
      post :admin, to: 'admin#create'
      delete :admin, to: 'admin#destroy'
    end
  end
  resources :notifications_users, only: [] do
    patch :update, on: :collection
  end

  get '/auth/discord/callback', to: 'users#create'
  get '/auth/:provider/callback', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  match '*path', to: 'application#routing_error', via: :all
end
