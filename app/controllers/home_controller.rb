class HomeController < ApplicationController
  before_filter :authenticate_user!, :except => :index

  def index
    return redirect_to user_root_path if user_signed_in?
  end

  def home
    @groups = current_user.groups
    @active = 'all'
    @posts = current_user.readable_posts.order('created_at DESC')
    return render 'home_admin' if current_user.admin?
  end
end
