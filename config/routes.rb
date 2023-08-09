Rails.application.routes.draw do
  root "home#index"
  resources :assemblies
  resources :parts
  resources :accounts
  resources :suppliers
  resources :books
  resources :authors

  namespace :api, defaults: { format: :json } do
    resources :authors, :suppliers, :books, :accounts, only: %i[index show create update destroy]
    resources :assemblies, only: %i[index show create update]
  end
end
