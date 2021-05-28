Rails.application.routes.draw do
  root "application#welcome"
  get "welcome", to: "application#welcome", as: "welcome"
  post "login", to: "application#login", as: "login"
  get "login", to: "application#login"
  post "signup", to: "users#signup", as: "signup"
  get "signup", to: "users#signup"
  get "order_again/:id", to: "deliveries#order_again", as: "order_again"
  post "order_delivered/:id", to: "deliveries#completed", as: "order_delivered"
  get "logout", to: "sessions#destroy", as: "logout"
  get "delete/:id", to: "users#delete", as: "delete_user"
  get "hard_delete/:id", to: "users#hard_delete", as: "hard_delete"
  get "add_funds/:id", to: "users#add_funds", as: "add_funds"
  post "add_funds/:id", to: "users#funds_added"
  post "sessions/create", to: "sessions#create"
  get "end_session", to: "application#end_session"
  get "fix_my_session", to: "application#fix_session"
  post "users/:id/deliveries/new_user_delivery", to: "deliveries#payment_options"
  post "guests/new", to: "guests#create", as: "new_guest"
  get "guests/deliveries/new", to: "deliveries#new", as: "guest_delivery"
  get "user/:user_id/delivery/:del_id/pay_with_credit", to: "deliveries#pay_with_credit", as: "pay_with_credit"
  get "user/delivery/:del_id/pay_with_cash", to: "deliveries#pay_with_cash", as: "pay_with_cash"


  resources :users, only: [:new, :create, :edit, :update, :show] do
    resources :deliveries, only: [:index, :show, :new, :create] # Index - Shows all your deliveries, seperated by delivered or not. New makes a new.... duh. Edit non-destructively makes a new one
    resources :meals, only: [:new, :create, :update, :create, :index, :show]
  end

  namespace :admin do
    resources :users
    resources :deliveries
    resources :meals
  end

end
