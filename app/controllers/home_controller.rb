class HomeController < ApplicationController
  before_filter :authenticate_user!, :except => :index

  def index
    return redirect_to user_root_path if user_signed_in?
  end

  def home
    @post = Post.new
    @posts = Post.order('created_at DESC')
    @group = Group.new
    @groups = current_user.groups
    return render 'home_admin' if current_user.admin?
  end
end
