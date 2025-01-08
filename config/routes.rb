Rails.application.routes.draw do
  root "properties#index"
  resources :properties, only: [:index, :show]
  resources :searches, only: [:index]

  get "up" => "rails/health#show", as: :rails_health_check
end
