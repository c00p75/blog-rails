Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  devise_for :users, controllers: { sessions: "users/sessions" }
  root "users#index"

  resources :users, only: [:index, :show] do
    resources :posts do
      resources :comments, only: [:index, :create, :destroy]
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
