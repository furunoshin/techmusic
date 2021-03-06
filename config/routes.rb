Rails.application.routes.draw do
  root to: 'users#new'

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  get 'signup', to: 'users#new'
  resources :users do
    member do
      get :followings
      get :followers
      get :likes
      get :like_comments
    end
  end

  resources :posts do
    collection do
      get :search
    end
    resources :comments, only: [:new, :show, :edit, :update, :create, :destroy]
  end
  resources :relationships, only: [:create, :destroy]
  resources :favorites, only: [:create, :destroy]
  resources :comment_favorites, only: [:create, :destroy]
  
    
end