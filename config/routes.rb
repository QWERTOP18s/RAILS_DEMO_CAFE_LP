Rails.application.routes.draw do
  get '/errors/not_found', to: 'errors#not_found'
  get '/errors/internal_server_error', to: 'errors#internal_server_error'

  get 'products/index'
  get 'products/show'
  get 'products/new'
  get 'products/edit'
  root 'static_pages#home'
  get 'static_pages/home'
  get '/about', to: 'static_pages#about'

  resources :products

  # match "/404", to: "errors#not_found", via: :all
  # match "/500", to: "errors#internal_server_error", via: :all

  # get '*path', to: 'errors#not_found'

  match '*path', to: 'errors#not_found', via: :all, constraints: lambda { |req|
    req.path.exclude? 'rails/active_storage'
  }
end
