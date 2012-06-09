class Api::V1::RepliesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :check_format

  def index
    @post = Post.find(params[:post_id])
    authorize! :read, @post.group
    @replies = @post.replies
  end

  def create
    @post = Post.find(params[:post_id])
    authorize! :read, @post.group
    @reply = @post.replies.build(params[:reply])
    @reply.author = current_user
    if @reply.save
      render 'reply', :status => :created
    else
      render :text => @reply.errors.full_messages, :status => :unprocessable_entity
    end
  end

end
