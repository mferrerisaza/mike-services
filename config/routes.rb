Rails.application.routes.draw do

  devise_for :users
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
  get '/service-worker.js', to: "service_worker#service_worker"
  get '/manifest.json', to: "service_worker#manifest"
  get '/offline.html', to: "service_worker#offline"
  root to: 'pages#home'
end
