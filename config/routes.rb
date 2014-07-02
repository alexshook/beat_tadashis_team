Rails.application.routes.draw do
  devise_for :users
  root to: 'users#show'
  resources :users, only: [:show]
  resources :meals, except: [:edit, :update, :destroy]
  resources :ratings, only: [:index, :create, :destroy]
  resources :companies, only: [:index]
  resources :goals, only: [:create]
  get '/get_meals' => 'meals#grab_meals'
end
