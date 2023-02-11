Rails.application.routes.draw do
  resources :reviews
  resources :transactions
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

  devise_for :admins, path: 'admins', controllers: {
    sessions: 'admins/sessions',
    registrations: 'admins/registrations'
  }
end
