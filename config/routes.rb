require 'sidekiq/web'

Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq'

  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks',
    confirmations: 'users/confirmations',
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    passwords: 'users/passwords'
  }

  resources :topics
  resources :replies
  resources :users, only: :index, param: :username do
    get :topics, on: :member
    get :replies, on: :member
    get :favorites, on: :member
  end
  resources :notifications, only: [:index, :destroy]
  resources :favorites, only: [:create, :destroy] do
    delete :destroy, on: :collection
  end
  resource :avatar, only: :update

  get  'qiniu_uptoken', to: 'qiniu_uptoken#show'
  post 'markdown_preview', to: 'markdown_preview#show'
  get  'search', to: 'search#show'

  get ':username', to: 'users#show', username: /\w+/, as: :user

  root 'topics#index'
end
