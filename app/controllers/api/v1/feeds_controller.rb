class Api::V1::FeedsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :check_format

  def group_all
    params[:page] ||= 1
    params[:per_page] ||= 10
    params[:per_page] = (params[:per_page].to_f / 3).ceil
    if params[:group_id] == 'home'
      @feed_items = []
      for association in [:posts, :books]
        @feed_items += current_user.readable(association)
          .paginate(:page => params[:page], :per_page => params[:per_page])
      end
    else
      group = Group.find(params[:group_id])
      authorize! :read, group
      @feed_items = []
      for association in [:posts, :board_pics, :books]
        @feed_items += group.send(association).order('created_at DESC')
          .paginate(:page => params[:page], :per_page => params[:per_page])
      end
    end
    @feed_items.sort!{|a,b| a.created_at <=> b.created_at }.reverse!
  end
end