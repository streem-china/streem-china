Rails.application.routes.draw do
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks',
    confirmations: 'users/confirmations',
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    passwords: 'users/passwords'
  }

  resources :topics
  resources :replies
  resources :users, only: :index
  resources :notifications, only: :index
  resources :favorites, only: [:create, :destroy] do
    delete :destroy, on: :collection
  end

  post 'markdown/convert', to: 'markdown#convert'
  get 'qiniu/uptoken', to: 'qiniu#uptoken'
  get '/:username', to: 'users#show', username: /[a-zA-Z0-9_]+/, as: :user

  root 'topics#index'
end
