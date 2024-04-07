Rails.application.routes.draw do
 
  root to:  'main#home'
  devise_for :users
  
  get '/about', to: 'main#about'
  get '/home', to: 'main#home'
  

  resources :categories
  
  resources :lessons do
    collection do
      get 'import_csv', to: 'lessons#import_csv'
      post 'import_csv', to: 'lessons#import'
      
    end
  end

  #users
   get 'user/index'
   get 'user/reserve'
   get 'cart', to: 'cart#show'
   post 'cart/add'
   post 'cart/remove'

   #payments
   post 'payments/create'
   get 'payments/success'
   get 'payments/pending'
   get 'payments/failure'
   post 'payments/notification'
   get 'payments/index'

  #Reservation
  resources :reservations do
    get 'edit_status', on: :member
    
  end
  get 'reservations/index'
  #Reservation linked to user page
  post 'reservations/create'

  #Admin
  authenticated :user, ->(user) { user.admin?} do
    mount Motor::Admin => '/motor_admin'
    match 'admin/users',   to: 'admin#users',   via: 'get'
    match 'admin/index',   to: 'admin#index',   via: 'get'

  end
  
  #profesores
    match 'coach/index',   to: 'coach#index',   via: 'get'
  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  
end
