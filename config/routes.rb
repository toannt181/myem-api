Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'application#index'
  resources :users
  resources :announcements
  post '/login', to: 'sessions#create'
  post '/signup', to: 'users#create'
  post '/oauth2', to: 'oauths#create'
end
