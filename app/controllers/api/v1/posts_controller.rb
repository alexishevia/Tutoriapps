class Api::V1::PostsController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource
  skip_load_and_authorize_resource :only => :index
  respond_to :json

  def index
    if params[:group_id] == 'home'
      @posts = current_user.readable_posts.order('created_at DESC')
    else
      group = Group.find(params[:group_id])
      authorize! :read, group
      @posts = group.posts.order('created_at DESC')
    end
  end

  def create
    if @enrollment.save
      render 'enrollment'
    else
      render  :json => @enrollment.errors.full_messages, 
              :status => :unprocessable_entity
    end
  end

  def create
    if params[:group_id]
      if params[:group_id] == 'home'
        @post.group = nil
      else
        @post.group = Group.find(params[:group_id])
      end
    end
    @post.author = current_user
    if @post.save
      render :json => @post
    else
      render :text => @post.errors.full_messages, :status => :unprocessable_entity
    end
  end

end
