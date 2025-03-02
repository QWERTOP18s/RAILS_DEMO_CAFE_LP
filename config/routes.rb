Rails.application.routes.draw do
  get 'products/index'
  get 'products/show'
  get 'products/new'
  get 'products/edit'
  root 'static_pages#home'
  get 'static_pages/home'
  get '/about', to: 'static_pages#about'

  resources :products
end
