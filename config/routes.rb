require 'sidekiq/web'
Rails.application.routes.draw do
  devise_for :users
  get 'pages/index'
  authenticate :user do
    mount Sidekiq::Web => "/tasks"
  end

  root to: 'pages#index'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
