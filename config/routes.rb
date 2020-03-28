Rails.application.routes.draw do
  root to: 'users#index'
  devise_for :users
  resources :users, only: %i[index show]
  resources :exercises
  resources :menus
end
