Rails.application.routes.draw do
  get '/product_import/new' => "product_import#new"

  post '/product_import' => "product_import#create"

  get '/store' => "store#index"
  get '/store/:id' => "store#show"
  get '/dashboard' => "dashboard#index"


  devise_for :users 
  devise_scope :user do
    get '/sign_up' => 'devise/registrations#new'
   
end
  resources :products 
  
  resources :categories
  resources :users

  
  root 'dashboard#index'
  
end
