Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: 'users/sessions' }
  root 'users#index'
  resources :users, only: [:index, :show] do
    resources :posts do 
      resources :comments
      resources :likes, only: [:create]
    end
  end
end
