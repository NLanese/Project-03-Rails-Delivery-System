Rails.application.routes.draw do
  root "application#welcome"
  get "welcome", to "application#welcome", as "welcome"
  post "login", to: "application#login", as: "login"
  post "signup", to: "users#signup", as: "signup"
  get "order_again", to: "users#edit", as: "order_again"
  get "logout", to: "sessions#destroy", as: "logout"
  get "delete/:user_id", to: "users#delete", as: "delete_user"
  get "hard_delete/:user_id", to "users#hard_delete", as: "hard_delete"


  resources :users, only: [:new, :create, :edit, :update, :show] do
    resources :deliveries, only: [:index, :show, :new, :create, :edit, :update] # Index - Shows all your deliveries, seperated by delivered or not. New makes a new.... duh. Edit non-destructively makes a new one
    resources :meals, only: [:new, :create, :update, :create, :index, :show]
  end
end
