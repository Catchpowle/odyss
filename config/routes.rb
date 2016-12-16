Rails.application.routes.draw do
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
