class Api::V1::RepliesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :check_format

  def index
    if post_type == 'post'
      @post = Post.find(params[:post_id])
    elsif post_type == 'book'
      @post = Book.find(params[:book_id])
    end
    authorize! :read, @post
    @replies = @post.replies
  end

  def create
    if post_type == 'post'
      @post = Post.find(params[:post_id])
    elsif post_type == 'book'
      @post = Book.find(params[:book_id])
    end
    authorize! :read, @post
    @reply = @post.replies.build(params[:reply])
    @reply.author = current_user
    if @reply.save
      render 'reply', :status => :created
    else
      render :text => @reply.errors.full_messages, :status => :unprocessable_entity
    end
  end

  private

    def post_type
      if request.fullpath.index('posts')
        return 'post'
      else
        return 'book'
      end
    end

end
