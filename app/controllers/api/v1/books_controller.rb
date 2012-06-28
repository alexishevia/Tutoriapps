class Api::V1::BooksController < ApplicationController
  before_filter :authenticate_user!
  before_filter :check_format

  def index
    params[:count] ||= 5

    if params[:newer_than]
      newer_than = Book.find(params[:newer_than]).created_at
    else
      newer_than = "2000-01-01".to_time
    end

    if params[:older_than]
      older_than = Book.find(params[:older_than]).created_at
    else
      older_than = "2100-01-01".to_time
    end

    if params[:group_id] == 'home'
      @books = current_user.readable(:books).where('created_at > ?', newer_than)
          .where('created_at < ?', older_than).order('created_at DESC')
          .limit(params[:count])
    else
      group = Group.find(params[:group_id])
      authorize! :read, group
      @books = group.books.where('created_at > ?', newer_than)
        .where('created_at < ?', older_than).order('created_at DESC')
        .limit(params[:count])
    end
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