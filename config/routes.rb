Rails.application.routes.draw do
  devise_for :users
  root to: 'tasks#index'
  resources :tasks
  resources :notifications, defaults: { format: :json }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
