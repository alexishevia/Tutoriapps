class EnrollmentsController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource

  def create
    respond_to do |format|
      format.js do
        if @enrollment.save
          render partial: '/enrollments/enrollment_admin', object: @enrollment
        else
          render :text => @enrollment.errors.full_messages[0], :status => 409
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