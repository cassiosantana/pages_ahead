Rails.application.routes.draw do
  root 'home#index'
  resources :assemblies
  resources :parts
  resources :accounts
  resources :suppliers
  resources :books
  resources :authors
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
