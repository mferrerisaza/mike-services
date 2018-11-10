Rails.application.routes.draw do
  devise_for :users
  root to: 'tasks#index'
  get '/koala', to: 'pages#koala', as: 'koala'
  resources :tasks
  resources :notifications, defaults: { format: :json }
  resources :playing_cards, only: :destroy
  require "sidekiq/web"
    authenticate :user, lambda { |u| u.admin } do
      mount Sidekiq::Web => '/sidekiq'
    end
end
