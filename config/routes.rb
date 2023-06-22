Rails.application.routes.draw do
  # devise gem authentication routes for users
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  # get 'pages/home', to: 'pages#home'
  # get 'pages/about', to: 'pages#about'

  # To make this the default homepage
  root to: "pages#home"

  get "about", to: "pages#about"

  # Gives all the articles routes
  resources :articles

  # users signup routes
  get "signup", to: "users#new"
  # users login and logout routes
  get "login", to: "sessions#new"
  post "login", to: "sessions#create"
  get "logout", to: "sessions#destroy"

  # users routes
  resources :users, except: [:new]

  # categories routes
  resources :categories, expect: [:destroy]
end
