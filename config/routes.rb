Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"

  resources :events do
    resources :participants, only: %i[new create]
    get "all_participants", to: "events#present", as: "custom"
  end
end
