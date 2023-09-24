# frozen_string_literal: true

Rails.application.routes.draw do
  resources :accounts

  namespace :admin do
    resources :assemblies, :parts
    resources :books, :authors, :suppliers do
      get :report, on: :member
    end
  end

  namespace :api, defaults: { format: :json } do
    resources :authors, :suppliers, :books, :accounts, :assemblies, :parts, only: %i[index show create update destroy]
  end

  root "home#index"
end
