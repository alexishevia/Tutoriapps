Tutoriapps::Application.routes.draw do
  devise_for :users

  resources :groups do
    resources :posts, :only => :create
  end

  root :to => 'home#index'
end
