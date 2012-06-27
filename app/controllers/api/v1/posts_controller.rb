class Api::V1::PostsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :check_format

  def index
    params[:page] ||= 1
    params[:per_page] ||= 10
    if params[:group_id] == 'home'
      @posts = current_user.readable(:posts).order('created_at DESC')
        .paginate(:page => params[:page], :per_page => params[:per_page])
    else
      group = Group.find(params[:group_id])
      authorize! :read, group
      @posts = group.posts.order('created_at DESC')
        .paginate(:page => params[:page], :per_page => params[:per_page])
    end
  end

  def show
    @post = Post.find(params[:id])
    render 'post'
  end

  def create
    @post = Post.new(params[:post])
    if params[:group_id] != 'home'
      group = Group.find(params[:group_id])
      authorize! :read, group
      @post.group = group
    end
    @post.author = current_user
    if @post.save
      render 'post', :status => :created
    else
      render :json => @post.errors.full_messages, :status => :unprocessable_entity
    end
  end

end
