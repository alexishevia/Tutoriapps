Tutoriapps::Application.routes.draw do
  root :to => 'home#index'
  devise_for :users

  namespace :api do
    namespace :v1 do
      resources :tokens, :only => [:create, :destroy]
      resources :groups, :only => [:index, :create, :update, :destroy] do
        resources :posts, :only => [:index, :create]
      end
      resources :enrollments, :only => [:create, :destroy]
      resources :feedbacks, :only => [:create]
    end
  end

end
