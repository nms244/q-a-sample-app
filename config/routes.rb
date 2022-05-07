Rails.application.routes.draw do
  root 'questions#index'

  get    '/login',  to: 'sessions#new'
  post   '/login',  to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  resources :users
  resources :questions do
    resources :answers, only: %i[create destroy]
    member do
      post :solve
    end
    collection do
      get :unsolved, :solved
    end
  end

  namespace :admin do
    get    '/login', to: 'sessions#new'
    post   '/login', to: 'sessions#create'
    resources :users, only: %i[index destroy]
    resources :questions, only: %i[index destroy]
  end
end
