Rails.application.routes.draw do
  root "home#index"
  resources :assemblies
  resources :parts
  resources :accounts
  resources :suppliers
  resources :books
  resources :authors

  namespace :api, defaults: { format: :json } do
    resources :authors, only: %i[index show create]
  end
end
