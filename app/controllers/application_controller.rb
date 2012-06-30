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

  def load_paging_params
    params[:count] ||= 5
    params[:count] = params[:count].to_i

    if params[:newer_than]
      begin
        params[:newer_than] = params[:newer_than].to_time
      rescue ArgumentError => e
        return render :json => {:errors => e.to_s}, :status => :bad_request
      end
    else
      params[:newer_than] = "2000-01-01".to_time
    end

    if params[:older_than]
      begin
        params[:older_than] = params[:older_than].to_time
      rescue ArgumentError => e
        return render :json => {:errors => e.to_s}, :status => :bad_request
      end
    else
      params[:older_than] = "2100-01-01".to_time
    end
  end
end