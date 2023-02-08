Rails.application.routes.draw do
  root to: 'landing#index'
  get 'dashboard/index', as: :authenticated_root
  resources :books

  namespace :admins do
    resources :users, :controller => "users"
  end


  devise_for :users, path: 'users', controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
  # resources :users, :controller => "users"

  devise_for :admins, path: 'admins', controllers: {
    sessions: 'admins/sessions',
    registrations: 'admins/registrations'
  }

  # devise_scope :user do
  #   authenticated :user do
  #     namespace :users do
  #       get 'dashboard/index', as: :authenticated_root
  #     end
  #   end
  # end
  #
  # devise_scope :admin do
  #   authenticated :admin do
  #     namespace :admins do
  #       get 'dashboard/index', as: :authenticated_root
  #     end
  #   end
  # end
end
