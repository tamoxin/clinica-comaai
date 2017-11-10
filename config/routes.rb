Rails.application.routes.draw do

  resources :users
  resources :courses do
    resources :cfolders do
      resources :cposts
    end
  end
  resources :groups do
    resources :students
    resources :gfolders do
      resources :gposts
    end
  end

  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'


  root 'users#index'

end
