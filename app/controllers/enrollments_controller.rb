class EnrollmentsController < ApplicationController
  def create
    @group = Group.find(params[:group_id])
    enrollment = @group.enrollments.build(params[:enrollment])
    if enrollment.save
      redirect_to @group, :notice => I18n.t('helpers.messages.added', 
        :model => I18n.t('activerecord.models.user'))
    else
    end
  end
end