class Api::V1::EnrollmentsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :check_format

  def create
    authorize! :create, Enrollment
    @enrollment = Enrollment.new(params[:enrollment])
    if @enrollment.save
      render 'enrollment', :status => :created
    else
      render  :json => @enrollment.errors.full_messages, 
              :status => :unprocessable_entity
    end
  end

  def destroy
    authorize! :destroy, Enrollment
    @enrollment = Enrollment.find(params[:id])
    @enrollment.destroy
    render :nothing => true if @enrollment.destroyed?
  end
end