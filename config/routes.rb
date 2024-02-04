Rails.application.routes.draw do
  resources :lessons
  get 'admin/index'
  resources :categories
  devise_for :users
  root to:  'main#home'
  
  get '/about', to: 'main#about'
  get '/home', to: 'main#home'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  
end
