Rails.application.routes.draw do
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks'
  }

  devise_scope :user do
    get 'sign_out', to: 'devise/sessions#destroy', as: :destroy_user_session
    get 'sign_in',  to: 'users/sessions#new', as: :new_user_session
  end

  resources :topics
  resources :replies
  resources :notifications, only: :index
  resources :favorites, only: [:create, :index] do
    delete :destroy, on: :collection
  end

  post 'markdown/convert', to: 'markdown#convert'
  get '/:username', to: 'users#show', username: /[a-zA-Z0-9_]+/, as: :user

  root 'topics#index'
end
