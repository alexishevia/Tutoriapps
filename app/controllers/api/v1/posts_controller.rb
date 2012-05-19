class Api::V1::PostsController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource
  skip_load_and_authorize_resource :only => :index
  respond_to :json

  def index
    if params[:group_id]
      group = Group.find(params[:group_id])
      authorize! :read, group
      @posts = group.posts
    else
      @posts = current_user.readable_posts.order('created_at DESC')
    end
  end

  def create
    @post.author = current_user
    if @post.save
      respond_with @post
    else
      render :text => @post.errors.full_messages[0], :status => 409
    end
  end

end
