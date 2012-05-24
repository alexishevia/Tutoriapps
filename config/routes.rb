Tutoriapps::Application.routes.draw do
  root :to => 'home#index'
  devise_for :users

  namespace :api do
    namespace :v1 do
      resources :tokens, :only => [:create, :destroy]
      resources :groups do
        resources :posts, :only => [:index, :create]
      end
      resources :posts, :only => [:create]
      resources :enrollments, :only => [:create, :destroy]
    end
  end

end
