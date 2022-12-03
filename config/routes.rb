Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "users#index"

  resources :users, only: %i[index show] do
    resources :posts, only: %i[index show new create], as: :posts do 
      resources :comments, only: %i[new create]
    end
  end
end
