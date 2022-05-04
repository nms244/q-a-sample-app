Rails.application.routes.draw do
  namespace :admin do
    get 'questions/index'
    get 'questions/destroy'
  end
  root "questions#index"

  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  resources :users
  resources :questions do
    resources :answers, only: [:create, :destroy]
    collection do
      get :unsolved, :solved
      post :solve
    end
  end

  namespace :admin do
    get    '/login',   to: 'sessions#new'
    post   '/login',   to: 'sessions#create'
    resources :users, only: [:index, :destroy]
    resources :questions, only: [:index, :destroy]
  end
end
