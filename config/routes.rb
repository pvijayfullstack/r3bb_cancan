Rails3BlogBasic::Application.routes.draw do
  devise_for :users 

  resources :posts do
    resources :comments
  end

  get "home/index"
  
  root :to => "home#index"

end
