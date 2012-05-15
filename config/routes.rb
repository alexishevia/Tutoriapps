Tutoriapps::Application.routes.draw do
  root :to => 'home#index'

  devise_for :users

  resources :groups do
    resources :posts, :only => :create
  end

  resources :enrollments, :only => [:create, :destroy]
  resources :posts, :only => :create

  namespace :api do
    namespace :v1 do
      resources :tokens, :only => [:create, :destroy]
    end
  end

end
