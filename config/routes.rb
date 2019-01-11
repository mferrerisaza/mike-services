Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  get '/koala', to: 'pages#koala', as: 'koala'
  get '/papelitos', to: 'pages#papelitos', as: 'papelitos'
  resources :tasks
  resources :notifications, defaults: { format: :json }
  resources :playing_cards, only: :destroy
  resources :teams, only: [:index, :show, :new, :create]
  resources :players, only: [:index, :create]
  resources :papers, only: [:index, :new, :create, :update]
  get '/papelitos/reset', to: "papers#reset", as: 'reset_papelitos'
  require "sidekiq/web"
    authenticate :user, lambda { |u| u.admin } do
      mount Sidekiq::Web => '/sidekiq'
    end
end
