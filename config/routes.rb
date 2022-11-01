# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'customers#index'
  resources :customers, only: [:show, :new, :create]
  resources :teas, only: :index
end
