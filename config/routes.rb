Chitlist::Application.routes.draw do
  root "projects#index"
  get "/signin", to: "sessions#new"
  post "/signin", to: "sessions#create"
  
  resources :projects do
    resources :tasks
  end

  resources :users

  namespace :admin do
    root :to => "base#index"
    resources :users
  end
end
