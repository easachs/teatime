# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :customers, only: %i[show create]
      resources :subscriptions, only: %i[create update]
      # resources :teas, only: %i[index]
    end
  end
end
