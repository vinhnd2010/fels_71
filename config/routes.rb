Rails.application.routes.draw do
  root "static_pages#home"

  get "help" => "static_pages#help"
  get "about" => "static_pages#about"
  get "contact" => "static_pages#contact"
  get "login" => "sessions#new"
  post "login" => "sessions#create"
  delete "logout" => "sessions#destroy"

  resources :words, only: [:index]
  resources :lessons, only: [:index, :show]
  resources :categories, only: [:index, :show] do
    resources :lessons
  end

  namespace :admin do
    root "categories#index"
    resources :categories
    resources :users
    resource  :uploads, only: [:create]
    resources :words
  end

  resources :users do
    get "/:relationship" => "relationships#index", as: :relationship
  end

  resources :relationships, only: [:index, :create, :destroy]

end
