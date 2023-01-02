Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  resources :events do
    resources :participants, only: %i[new create]
  end
  # get "events/:event_id", to: "events#present", as: "present"
end
