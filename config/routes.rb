Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'application#index'
  resources :users
  resources :announcements
  get '/customers/sample', to: 'customers#sample'
  get '/customers/utf8', to: 'customers#csv'
  post '/customers/preview', to: 'customers#preview'
  resources :cities do
    get '/districts', to: 'cities#get_districts'
  end
  get '/districts/:district_id/wards', to: 'cities#get_wards'
  resources :customers do
    get '/company-info', to: 'companies#company_info'
    resources :companies
    get '/divisions', to: 'divisions#index'
    post '/divisions', to: 'divisions#create'
    resources :diagnoses
  end
  delete '/divisions/:id', to: 'divisions#destroy'
  post '/login', to: 'sessions#create'
  post '/signup', to: 'users#create'
  post '/oauth2', to: 'oauths#create'
end
