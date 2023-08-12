Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: "users/sessions" }
  root "users#index"
  # Add the route for the test user login
  devise_scope :user do
    get '/login_as_test_user', to: 'users/sessions#login_as_test_user', as: :login_as_test_user
  end

  resources :users, only: [:index, :show] do
    resources :posts do
      resources :comments
      resources :likes, only: [:create]
    end
  end
  
  namespace :api, defaults: { format: :json } do
    resources :users, only: [:index, :show] do
      resources :posts do
        resources :comments, only: [:index, :create, :destroy]
        resources :likes, only: [:create]
      end
    end
  end


end
