Rails.application.routes.draw do
  root "properties#index"
  resources :properties, only: [:index, :show]

  get "up" => "rails/health#show", as: :rails_health_check
end
