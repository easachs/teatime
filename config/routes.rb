# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :customers, path: 'register', only: %i[create]
      resources :subscriptions, only: %i[index create update]
      # resources :teas, only: %i[index]
    end
  end
end
