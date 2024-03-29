Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "museum_objects#index"

  resources :museum_objects, only: [:index, :create, :show], param: :system_number, system_number: /O\d+/ do
    get 'search', on: :collection
    member do
      resources :reflections, shallow: true
    end
  end

  resource :session
  resource :registration
  resource :password_reset
  resource :password

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
end
