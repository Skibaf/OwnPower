Rails.application.routes.draw do
  get 'coach/index'
  
  devise_for :users
  root to:  'main#home'

  get '/about', to: 'main#about'
  get '/home', to: 'main#home'
  

  #Admin
  match 'admin/users',   to: 'admin#users',   via: 'get'
  resources :lessons
  get 'admin/index'
  resources :categories

  #users
  get 'user/index'
  get 'user/reserve'

  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  
end
