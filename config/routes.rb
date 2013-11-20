Chitlist::Application.routes.draw do
  root "projects#index"
  
  resources :projects do
    resources :tasks
  end
end
