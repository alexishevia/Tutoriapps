Tutoriapps::Application.routes.draw do
  get '/home', :to => 'home#home', :as => 'user_root'

  devise_for :users

  resources :groups do
    resources :posts, :only => :create
  end

  resources :enrollments, :only => [:create, :destroy]
  resources :posts, :only => :create

  root :to => 'home#index'

  namespace :api do
    namespace :v1 do
      resources :tokens, :only => [:create, :destroy]
    end
  end

end
