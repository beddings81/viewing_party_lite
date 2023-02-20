Rails.application.routes.draw do
  root 'welcome#index'

  resources :users, only: [:new, :create]

  resources :dashboard, only: [:index]

  resources :viewing_parties, only: [:new, :create] 

  resources :invitees, only: [:create]

  resources :discover, only: [:index]

  resources :movies, only: [:index, :show]

  post '/', to: 'users#create'
  get '/login', to: 'users#login_form'
  post '/login', to: 'users#login_user'
  get '/logout', to: 'users#logout_user'

  namespace :admin do
    resources :dashboard, only: [:index]
    resources :users, only: [:show]
  end
end
