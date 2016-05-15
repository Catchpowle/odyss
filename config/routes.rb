Rails.application.routes.draw do
  root to: 'pages#index'

  resources :users, except: [:create]

  get '/auth/slack/callback', to: 'users#create'
  get '/auth/:provider/callback', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
end
