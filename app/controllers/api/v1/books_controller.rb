class Api::V1::BooksController < ApplicationController
  before_filter :authenticate_user!
  before_filter :check_format
  before_filter :load_paging_params, :only => :index

  def index
    view = 'api/v1/books/index'
    if params[:group_id] == 'home'
      @books = current_user.readable(:books)
          .where('created_at > ?', params[:newer_than])
          .where('created_at < ?', params[:older_than])
          .order('created_at DESC').limit(params[:count])
      if params[:include_replies]
        view = 'api/v1/feeds/group_all'
        @feed_items = @books + Reply.where('created_at > ?', params[:newer_than])
          .where('created_at < ?', params[:older_than]).select{ |reply|
            reply.post_type == 'Book' and (
              reply.post.group_id == 'home' or
              reply.post.group.members.include? current_user
            )
          }
        @feed_items = @feed_items.sort{|a,b| a.created_at <=> b.created_at }
                      .reverse[0, params[:count]]
      end
    else
      group = Group.find(params[:group_id])
      authorize! :read, group
      @books = group.books
        .where('created_at > ?', params[:newer_than])
        .where('created_at < ?', params[:older_than])
        .order('created_at DESC').limit(params[:count])
      if params[:include_replies]
        view = 'api/v1/feeds/group_all'
        @feed_items = @books + Reply.where('created_at > ?', params[:newer_than])
          .where('created_at < ?', params[:older_than]).select{ |reply|
            reply.post_type == 'Book' and reply.post.group.id == group.id }
        @feed_items = @feed_items.sort{|a,b| a.created_at <=> b.created_at }
                      .reverse[0, params[:count]]
      end
    end
    render view
  end

  def create
    @book = Book.new(params[:book])
    if params[:group_id] != 'home'
      group = Group.find(params[:group_id])
      authorize! :read, group
      @book.group = group
    end
    @book.owner = current_user
    if @book.save
      render 'book', :status => :created
    else
      render :json => @book.errors.full_messages, :status => :unprocessable_entity
    end
  end
end