class HomeController < ApplicationController
  before_filter :authenticate_user!, :except => :index

  def index
    redirect_to user_root_path if user_signed_in?
    render :layout => false
  end

  def home
    if can? :manage, Group
      @groups = Group.all
    else
      @groups = current_user.groups
    end 
  end
end
