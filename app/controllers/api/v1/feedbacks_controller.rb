class Api::V1::FeedbacksController < ApplicationController
  before_filter :authenticate_user!
  before_filter :check_format

  def create
    authorize! :create, Feedback
    @feedback = Feedback.new(params[:feedback])
    @feedback.user = current_user
    if @feedback.save
      render :json => @feedback, :status => :created
    else
      render :json => @feedback.errors.full_messages, :status => :unprocessable_entity
    end
  end
end