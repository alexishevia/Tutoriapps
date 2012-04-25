class HomeController < ApplicationController
  before_filter :authenticate_user!, :except => :index

  def index
    redirect_to user_root_path if user_signed_in?
  end

  def home
    @groups = current_user.groups
  end
end
