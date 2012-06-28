class Api::V1::PostsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :check_format

  def index
    params[:count] ||= 5

    if params[:newer_than]
      newer_than = Post.find(params[:newer_than]).created_at
    else
      newer_than = "2000-01-01".to_time
    end

    if params[:older_than]
      older_than = Post.find(params[:older_than]).created_at
    else
      older_than = "2100-01-01".to_time
    end

    if params[:group_id] == 'home'
      @posts = current_user.readable(:posts).where('created_at > ?', newer_than)
          .where('created_at < ?', older_than).order('created_at DESC')
          .limit(params[:count])
    else
      group = Group.find(params[:group_id])
      authorize! :read, group
      @posts = group.posts.where('created_at > ?', newer_than)
        .where('created_at < ?', older_than).order('created_at DESC')
        .limit(params[:count])
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
