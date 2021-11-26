require 'sidekiq/web'
require 'sidekiq/cron/web'
Rails.application.routes.draw do

  resources :request_labels, except: %i[edit destroy] do
    member do
      post :retry
    end
  end
  resources :tokens, except: %i[show]

  devise_for :users
  get 'pages/index'
  authenticate :user do
    mount Sidekiq::Web => "/tasks"
  end

  root to: 'pages#index'


 scope "/labels" do
  get '/:id/download' => "api#request_download"
 end

  scope '/api' do
    scope '/v1' do
      scope '/skydropx' do
        get '/ping' => 'api#ping'
        scope '/labels' do
          post '/request' => "api#request_label"
          get '/check' => "api#request_check"

        end
      end
    end
  end


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
