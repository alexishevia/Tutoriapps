class ApplicationController < ActionController::Base
  protect_from_forgery
  rescue_from CanCan::AccessDenied, :with => :forbidden

  def forbidden
    render "#{Rails.root}/public/403", :status => :forbidden
  end
end
