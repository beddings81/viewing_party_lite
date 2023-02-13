Rails.application.routes.draw do
  resources :welcome, only: [:index]

  resources :users, only: [:new, :create] do
    resources :dashboard, only: [:index]
    resources :movies, only: [:index, :show] do
      resources :viewing_parties, only: [:new, :create] do
        resources :invitees, only: [:create]
      end
    end
    resources :discover, only: [:index]
  end
  post '/welcome', to: 'users#create'
  get '/login', to: 'users#login_form'
  post '/login', to: 'users#login_user'
end
