Rails.application.routes.draw do
  root to: 'menus#index'
  devise_for :users
  resources :users, only: %i[index show]
  resources :exercises
  resources :menus
  resources :workouts
end
