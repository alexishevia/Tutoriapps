class HomeController < ApplicationController
  def index
    if user_signed_in?
      render 'home'
    else
      render 'index'
    end
  end

  def fileupload
  end
end
