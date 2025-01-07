Rails.application.routes.draw do
  get 'properties/index'
  root "properties#index"
  resources :properties, only: [:index]

  get "up" => "rails/health#show", as: :rails_health_check
end
