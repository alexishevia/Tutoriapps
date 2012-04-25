class HomeController < ApplicationController
  before_filter :authenticate_user!, :except => :index

  def index
  end

  def home
    @groups = current_user.groups
  end
end
