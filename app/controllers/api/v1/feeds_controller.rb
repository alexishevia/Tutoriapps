class Api::V1::FeedsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :check_format
  before_filter :load_paging_params

  def group_all
    if params[:group_id] == 'home'
      @feed_items = []
      for association in [:posts, :board_pics, :books]
        @feed_items += current_user.readable(association)
          .where('created_at > ?', params[:newer_than])
          .where('created_at < ?', params[:older_than])
          .order('created_at DESC').limit(params[:count])
      end
      if params[:include_replies]
        @feed_items += Reply.where('created_at > ?', params[:newer_than])
          .where('created_at < ?', params[:older_than]).select{ |reply|
            reply.post.group_id == 'home' or reply.post.group.members.include? current_user
          }
      end
    else
      group = Group.find(params[:group_id])
      authorize! :read, group
      @feed_items = []
      for association in [:posts, :board_pics, :books]
        @feed_items += group.send(association)
          .where('created_at > ?', params[:newer_than])
          .where('created_at < ?', params[:older_than])
          .order('created_at DESC').limit(params[:count])
      end
      if params[:include_replies]
        @feed_items += Reply.where('created_at > ?', params[:newer_than])
          .where('created_at < ?', params[:older_than]).select{ |reply|
            reply.post.group_id == group.id
          }
      end
    end
    @feed_items = @feed_items.sort{|a,b| a.created_at <=> b.created_at }
                  .reverse[0, params[:count]]
  end
end