class Api::V1::GroupsController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource
  skip_load_and_authorize_resource :only => :show
  respond_to :json

  def index
    @groups = current_user.groups
  end

  def show
    groups = current_user.groups
    if params[:id] == "all"
      active = 'all'
      posts = current_user.readable_posts.order('created_at DESC')
    else
      group = Group.find_by_id(params[:id])
      authorize! :read, group
      active = group
      posts = group.posts.order('created_at DESC')
    end
    respond_to do |format|
      format.js do 
        render :layout => false, :partial => '/home/timeline', 
          :locals => { :groups => groups, :active => active, :posts => posts }
      end
    end
  end

  def create
    respond_to do |format|
      format.json do
        if @group.save
          render :json => @group
        else
          render :json => @group.errors.full_messages, :status => :unprocessable_entity
        end
      end
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
    respond_to do |format|
      format.js do
        render :nothing => true if @group.destroyed?
      end
    end
  end
end