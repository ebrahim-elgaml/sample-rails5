Rails.application.routes.draw do
  resources :users, only: :create
  post "users/login"
  get "users/signout"
end
