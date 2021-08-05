Rails.application.routes.draw do
  get 'products/show'
  get 'welcome/index'


  post '/add_to_cart', to: "welcome#add_to_cart" 
  post '/remove_from_cart', to: "welcome#remove_from_cart" 

  get '/bucket', to: "welcome#bucket"

  post '/create_order', to: "welcome#create_order" 
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :products
  root to: 'welcome#index'
end
