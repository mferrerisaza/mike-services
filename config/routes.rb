Rails.application.routes.draw do
  devise_for :users
  root to: 'tasks#index'
  resources :tasks
  resources :notifications, defaults: { format: :json }
  require "sidekiq/web"
    authenticate :user, lambda { |u| u.admin } do
      mount Sidekiq::Web => '/sidekiq'
    end
end
