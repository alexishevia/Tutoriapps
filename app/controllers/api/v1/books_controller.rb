class Api::V1::BooksController < ApplicationController
  before_filter :authenticate_user!
  before_filter :check_format

  def index
    params[:newer_than] ||= 0
    params[:older_than] ||= 99999999
    params[:count] ||= 5

    if params[:group_id] == 'home'
      @books = current_user.readable(:books).where('id > ?', params[:newer_than])
          .where('id < ?', params[:older_than]).order('created_at DESC')
          .limit(params[:count])
    else
      group = Group.find(params[:group_id])
      authorize! :read, group
      @books = group.books.where('id > ?', params[:newer_than])
        .where('id < ?', params[:older_than]).order('created_at DESC')
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