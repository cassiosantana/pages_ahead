# frozen_string_literal: true

Rails.application.routes.draw do
  resources :suppliers, :books, :accounts, :assemblies, :parts
  resources :authors do
    get :report, on: :member
  end

  namespace :api, defaults: { format: :json } do
    resources :authors, :suppliers, :books, :accounts, :assemblies, :parts, only: %i[index show create update destroy]
  end

  root "home#index"
end
