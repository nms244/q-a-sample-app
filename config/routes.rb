Rails.application.routes.draw do
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  resources :users, only: [:index, :new, :create]
  resources :questions do
    resources :answers, only: [:create, :destroy]
    collection do
      get :unsolved, :solved
    end
  end

  namespace :admin do
    get    '/login',   to: 'sessions#new'
    resources :users, only: [:index, :destroy]
    resources :questions, only: [:index, :destroy]
  end
end
