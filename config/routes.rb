Tutoriapps::Application.routes.draw do
  get '/home', :to => 'home#home', :as => 'user_root'

  devise_for :users

  resources :groups do
    resources :posts, :only => :create
    resources :enrollments, :only => :create
  end

  root :to => 'home#index'
end
