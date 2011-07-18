Rails3BlogBasic::Application.routes.draw do
  
  resources :goals do
    resources :results
  end

  resources :workouts do
    resources :activities
  end

  resources :exercises

  devise_for :users 

  resources :posts do
    resources :comments
  end

  get "home/index"
  
  root :to => "home#index"

end
