Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :sushi
  resources :user
  resources :about
  root to: 'about#index'
end
