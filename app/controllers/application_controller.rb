class ApplicationController < ActionController::Base
  protect_from_forgery
  rescue_from CanCan::AccessDenied, :with => :forbidden

  def forbidden
    render :json => {:error => 'AccessDenied'}, :status => :forbidden
  end


  def authenticate_admin!
    authenticate_user!
    unless current_user.admin?
      raise CanCan::AccessDenied
    end
  end
end
