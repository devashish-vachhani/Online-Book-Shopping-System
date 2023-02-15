Rails.application.routes.draw do
  root to: 'landing#index'
  get 'dashboard/index', as: :authenticated_root
  devise_for :admins, path: 'admins', controllers: {
    sessions: 'admins/sessions',
    registrations: 'admins/registrations'
  }
  namespace :admins do
    resources :users, :controller => "users"
  end
  devise_for :users, path: 'users', controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
  resources :books
  resource :shopping_cart
  resources :shopping_cart_items
  resources :transactions
  resources :reviews
end
