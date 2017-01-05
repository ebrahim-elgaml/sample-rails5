Rails.application.routes.draw do
  resources :users, only: :create
  post "users/login"
  get "users/signout"

  resources :user_skills, only: :create
  get "user_skills/search"
end
