class Api::V1::GroupsController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource
  respond_to :json

  def index
    if params[:admin]
      authorize! :manage, Group
      @groups = Group.all
      render 'admin_index'
    else
      @groups = current_user.groups
    end
  end

  def create
    if @group.save
      render :json => @group
    else
      render :json => @group.errors.full_messages, :status => :unprocessable_entity
    end
  end

  def update
    if @group.update_attributes(params[:group])
      render :json => @group
    else
      render :json => @group.errors.full_messages, :status => :unprocessable_entity
    end
  end

  def destroy
    @group.destroy
    render :nothing => true if @group.destroyed?
  end
end