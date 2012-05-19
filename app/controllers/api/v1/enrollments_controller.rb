class Api::V1::EnrollmentsController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource
  respond_to :json

  def create
    if @enrollment.save
      render 'enrollment'
    else
      render  :json => @enrollment.errors.full_messages, 
              :status => :unprocessable_entity
    end
  end

  def destroy
    @enrollment.destroy
    render :nothing => true if @enrollment.destroyed?
  end
end