class Api::V1::BoardPicsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :check_format

  def index
    group = Group.find(params[:group_id])
    authorize! :read, group
    @board_pics = group.board_pics
  end

  def create
    if(params[:group_id] == 'home')
      return render :json => {:errors => "Home can't have board_pics."},
                    :status => :unprocessable_entity
    end
    group = Group.find(params[:group_id])
    authorize! :read, group
    @board_pic = BoardPic.new(params[:board_pic])
    @board_pic.author = current_user
    @board_pic.group = group
    if @board_pic.save
      render 'board_pic', :status => :created
    else
      render :json => @board_pic.errors.full_messages, :status => :unprocessable_entity
    end
  end
end