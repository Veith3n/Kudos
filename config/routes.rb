Rails.application.routes.draw do
  devise_scope :user do
    get 'login', to: 'devise/sessions#new', as: :new_user_session
    get 'register', to: 'devise/registrations#new', as: :new_user_registration
    post 'sign_in', to: 'devise/sessions#create', as: :user_session
    delete 'sign_out', to: 'devise/sessions#destroy', as: :destroy_user_session
  end

  devise_for :users, skip: [:sessions], :controllers => { omniauth_callbacks: "users/omniauth_callbacks" }

  resources :users, only: [:index] do
    member do
      get '/give_kudo' => 'users#give_kudo'
    end
  end
  get '/top_10_users' => 'users#top10'

  resources :teams, except: [:edit, :update, :destroy] do
    member do
      get '/add_member' => 'teams#add_member'
      get '/remove_member' => 'teams#remove_member'
    end
  end

  get 'landing_page/index'
  get 'terms_of_service' => 'terms_of_service#index'

  root 'landing_page#index'
end
