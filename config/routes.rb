Tutoriapps::Application.routes.draw do
  get '/home', :to => 'home#home', :as => 'home'
  devise_for :users

  resources :groups do
    resources :posts, :only => :create
  end

  root :to => 'home#index'
end
