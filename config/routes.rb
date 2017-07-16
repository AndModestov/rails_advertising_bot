Rails.application.routes.draw do
  require 'sidekiq/web'

  mount Sidekiq::Web => '/sidekiq'
  mount ActionCable.server => '/cable'

  namespace :my_target do
    resources :accounts, only: [:show, :index, :create, :update, :destroy] do
      patch :synchronize, on: :member
    end
  end

  root to: 'my_target/accounts#index'
end
