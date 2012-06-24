Tutoriapps::Application.routes.draw do
  root :to => 'home#index'
  devise_for :users

  namespace :api do
    namespace :v1 do
      resources :tokens, :only => [:create, :destroy]
      resources :groups, :only => [:index, :create, :update, :destroy] do
        resources :posts, :books, :only => [:index, :create, :show]
        resources :board_pics, :only => [:index, :create]
        get 'all', :to => 'feeds#group_all'
      end
      resources :enrollments, :only => [:create, :destroy]
      resources :feedbacks, :only => [:create]
      resources :posts, :books, :only => [] do
        resources :replies, :only => [:index, :create]
      end
      get 'system_time.json', :to => 'system_info#time'
    end
  end

end
