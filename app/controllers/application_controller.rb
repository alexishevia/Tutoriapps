class Tutoriapps::RequestNotAcceptable < StandardError
end

class ApplicationController < ActionController::Base
  protect_from_forgery
  rescue_from CanCan::AccessDenied, :with => :forbidden
  rescue_from ActiveRecord::RecordNotFound, :with => :not_found
  rescue_from Tutoriapps::RequestNotAcceptable, :with => :not_acceptable

  def forbidden
    render :json => {:error => 'Forbidden (403)'}, :status => :forbidden
  end

  def not_found
    render :json => {:error => 'Not Found (404)'}, :status => :not_found
  end

  def not_acceptable
    render :json => {:error => 'Not Acceptable (406)'}, :status => :not_acceptable
  end

  def check_format(acceptable_formats = ['application/json', :json])
    unless acceptable_formats.include? request.format
      raise Tutoriapps::RequestNotAcceptable
    end
  end

  def authenticate_admin!
    authenticate_user!
    unless current_user.admin?
      raise CanCan::AccessDenied
    end
  end
end