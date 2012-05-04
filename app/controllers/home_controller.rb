class HomeController < ApplicationController
  before_filter :authenticate_user!, :except => :index

  def index
    return redirect_to user_root_path if user_signed_in?
  end

  def home
    if current_user.admin?
      @groups = Group.all
      return render 'home_admin'
    end 
  end
end
