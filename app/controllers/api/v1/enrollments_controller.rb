class EnrollmentsController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource

  def create
    respond_to do |format|
      format.json do
        if @enrollment.save
          render :json => @enrollment
        else
          render :json => @enrollment.errors.full_messages, :status => :unprocessable_entity
        end
      end
    end
  end

  def destroy
    @enrollment.destroy
    respond_to do |format|
      format.js do
        render :nothing => true if @enrollment.destroyed?
      end
    end
  end
end