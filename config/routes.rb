Rails.application.routes.draw do
  resources :products, only: [:index]
  resources :carts, only: [:show, :update, :destroy]
  resources :items, only: [:create]
  root "products#index"
end
