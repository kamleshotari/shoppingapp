Rails.application.routes.draw do
  resources :orders
  
  resources :line_items
  resources :carts
  get '/product_import/new' => "product_import#new"

  post '/product_import' => "product_import#create"

  get '/store' => "store#index"
  get '/store/cart_details' => "store#cart_details"
   get '/store/error' => "store#error"
  get 'store/current_user_details' => "store#current_user_details"
  get '/store/:id' => "store#show"
  get '/charges/new' => "charges#create"
  get '/dashboard' => "dashboard#index"
  

  devise_for :users,  :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" } 
  devise_scope :user do
    get '/sign_up' => 'devise/registrations#new'
    #delete 'sign_out', :to => 'devise/sessions#destroy', :as => :destroy_user_session
   
end
  resources :products 
  
  resources :categories
  resources :users

  
  root 'dashboard#index'
  
end
