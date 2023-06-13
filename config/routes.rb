Rails.application.routes.draw do
  # Define your application routes.
  root 'users#index'    # Seting users#index as root url
  # Using resources automatically allows the use of RESTful actions, i.e. get, post, put, delete.
  resources :users, only: [:index, :show] do
    resources :posts, only: [:index, :show]
  end
end
