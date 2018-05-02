Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :sushi do
    collection do
      get ':id/test', to: 'sushi#test'
      get ':id/call', to: 'sushi#call'
    end
  end
  resources :organizations do
    collection do
      get ':id/join', to: 'organizations#join'
      patch ':id/add_org_to_user', to: 'organizations#add_org_to_user'
    end
  end
  resources :user
  resources :about
  root to: 'about#index'
  get '/contact', to: 'about#contact'
  get '/validsushi', to: 'validsushi#index'
  get '/import', to: 'validsushi#import'
  get '/auth/:provider/callback', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  get '/auth/failure', to: 'sessions#destroy'
  post '/', to: 'error#not_found'
  get '*all', to: 'error#not_found', constraints: lambda { |req|
    req.path.exclude? 'rails/active_storage'
  }
end
