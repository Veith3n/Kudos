Rails.application.routes.draw do
  devise_for :users

  resources :users, only: [:index]

  get 'landing_page/index'

  root 'landing_page#index'
end
