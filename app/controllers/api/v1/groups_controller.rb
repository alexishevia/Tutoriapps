class Api::V1::GroupsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :check_format
  load_and_authorize_resource
  respond_to :json

  def index
    if current_user.admin?
      @groups = [Group.new(:name => 'Todos')] + Group.all
    else
      @groups = [Group.new(:name => 'Todos')] + current_user.groups
    end
  end

  def create
    if @group.save
      render :json => @group, :status => :created
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