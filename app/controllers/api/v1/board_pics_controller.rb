class Api::V1::BoardPicsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :check_format
  before_filter :load_paging_params, :only => :index

  def index
    if params[:group_id] == 'home'
      dates = current_user.readable(:board_pics).select('class_date')
        .where('class_date > ?', params[:newer_than])
        .where('class_date < ?', params[:older_than])
        .group('class_date')
        .order('class_date DESC').limit(params[:count])
        .collect{|bp| bp.class_date}
      @board_pics = []
      for date in dates
        @board_pics += current_user.readable(:board_pics).where('class_date = ?', date)
      end
    else
      group = Group.find(params[:group_id])
      authorize! :read, group
      dates = group.board_pics.select('class_date')
        .where('class_date > ?', params[:newer_than])
        .where('class_date < ?', params[:older_than])
        .group('class_date')
        .order('class_date DESC')
        .limit(params[:count])
        .collect{|bp| bp.class_date}
      @board_pics = []
      for date in dates
        @board_pics += group.board_pics.where('class_date = ?', date)
      end
    end
    @board_pics
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