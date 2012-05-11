class GroupsController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource

  def show
    if can? :manage, Group
      @groups = Group.all
    else
      @groups = current_user.groups
    end 
    @post = @group.posts.build
    @enrollment = @group.enrollments.build
  end

  def create
    if @group.save
      if request.xhr?
        return render :layout => false, :partial => 'groups/group_admin', :object => @group
      else
        redirect_to root_path, :notice => I18n.t('helpers.messages.created', 
          :model => I18n.t('activerecord.models.group'))
      end
    else
      render :action => 'new'
    end
  end
end