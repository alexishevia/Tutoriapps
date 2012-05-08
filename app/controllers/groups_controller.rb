class GroupsController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource
  respond_to :html, :json

  def show
    if can? :manage, Group
      @groups = Group.all
    else
      @groups = current_user.groups
    end 
    @post = @group.posts.build
    @enrollment = @group.enrollments.build
  end

  def new
  end

  def create
    @group = Group.create(params[:group])
    respond_with @group
  end
end