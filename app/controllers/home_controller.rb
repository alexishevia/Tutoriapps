class HomeController < ApplicationController

  def index
    if user_signed_in?
      @groups = current_user.groups
      @active = 'all'
      @posts = current_user.readable_posts.order('created_at DESC')
      if current_user.admin?
        render 'home_admin'
      else
        render 'home'
      end
    else
      render 'index'
    end
  end
end
