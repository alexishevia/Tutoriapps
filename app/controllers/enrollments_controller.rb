class EnrollmentsController < ApplicationController
  before_filter :authenticate_user!

  def create
    @group = Group.find(params[:group_id])
    authorize! :manage, @group
    enrollment = @group.enrollments.build(params[:enrollment])
    respond_to do |format|
      format.json do
        if enrollment.save
          render :json => enrollment.to_json(:include => [:user])
        end
      end
      format.html do
        if enrollment.save
          redirect_to root_path, :notice => I18n.t('helpers.messages.added', 
            :model => I18n.t('activerecord.models.user'))
        end
      end
    end
  end
end