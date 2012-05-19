Tutoriapps::Application.routes.draw do
  root :to => 'home#index'
  devise_for :users

  resources :enrollments, :only => [:create, :destroy]
  resources :posts, :only => :create

  namespace :api do
    namespace :v1 do
      resources :tokens, :only => [:create, :destroy]
      resources :posts, :only => [:index]
      resources :groups, :only => [:index] do
        resources :posts, :only => [:index]
      end
      namespace :admin do
        resources :groups, :only => [:index]
      end
    end
  end

end
