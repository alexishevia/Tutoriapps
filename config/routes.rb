Tutoriapps::Application.routes.draw do
  root :to => 'home#index'
  match 'fileupload', :to => 'home#fileupload'
  devise_for :users

  namespace :api do
    namespace :v1 do
      resources :tokens, :only => [:create, :destroy]
      resources :groups, :only => [:index, :create, :update, :destroy] do
        resources :posts, :only => [:index, :create]
        resources :board_pics, :only => [:index, :create]
      end
      resources :enrollments, :only => [:create, :destroy]
      resources :feedbacks, :only => [:create]
      resources :posts, :only => [] do
        resources :replies, :only => [:index, :create]
      end
    end
  end

end
