Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_scope :user do
    root to: 'devise/sessions#new'
  end

  devise_for :users, :controllers => {
  :registrations => "users/registrations",
  }
  resources :profiles

  resources :exercises do
    collection do
      get :search
    end
  end

  resources :menus
  resources :workouts
  resources :body_statuses
  resources :charts, only: :index
  resources :calendars, only: :show
  resources :relationships, only: %i[index create destroy]

  resources :posts do
    resources :comments, except: :show
  end

  resources :likes, only: %i[index create destroy]

  resources :workout_logs, only: :index do
    collection do
      get :search
    end
  end
end
