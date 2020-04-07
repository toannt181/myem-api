Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'application#index'
  resources :users
  post '/login', to: 'sessions#store'
  post '/oauth2', to: 'oauths#store'
end
