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
    respond_to do |format|
      format.js do
        if @group.save
          return render :layout => false, :partial => 'groups/group_admin', 
            :object => @group
        else
          render :text => @group.errors.full_messages[0], :status => 409
        end
      end
    end
  end

  def update
    success = @group.update_attributes(params[:group])
    respond_to do |format|
      format.json { respond_with_bip(@group) }
    end
  end
end