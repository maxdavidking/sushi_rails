Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :sushi do
    collection do
      get 'test'
    end
  end
  resources :user
  resources :about
  root to: 'about#index'
  get '/auth/:provider/callback', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  get '/auth/failure', to: 'sessions#destroy'
end
