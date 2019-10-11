Rails.application.routes.draw do
  root "events#index"
  get       "/signup",        to: "users#new"
  post      "/signup",        to: "users#create"
  get       "login",          to: "sessions#new"
  post      "login",          to: "sessions#create"
  delete    "logout",         to: "sessions#destroy"
  resources :users, only: [:create, :new, :show]
  resources :sessions, only: [:create, :new, :destroy]
  resources :events, only: [:create, :new, :index, :show]
  resources :invitations,  only: [:create, :new]
end
