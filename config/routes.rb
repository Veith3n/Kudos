Rails.application.routes.draw do
  devise_scope :user do
    get 'login', to: 'devise/sessions#new', as: :new_user_session
    get 'register', to: 'devise/registrations#new', as: :new_user_registration
    post 'sign_in', to: 'devise/sessions#create', as: :user_session
    delete 'sign_out', to: 'devise/sessions#destroy', as: :destroy_user_session
  end

  devise_for :users, skip: [:sessions]

  resources :users, only: [:index]

  get 'landing_page/index'

  root 'landing_page#index'
end
