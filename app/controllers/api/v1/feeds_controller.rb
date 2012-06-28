class Api::V1::FeedsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :check_format

  def group_all
    params[:count] ||= 5

    if (params[:newer_than] or params[:older_than])
      klass = params[:type].to_s.singularize.camelcase.constantize
      return (render :json => {:errors => "object_type missing"},
        :status => :bad_request) unless klass.respond_to?(:find)
    end

    if params[:newer_than]
      newer_than = klass.find(params[:newer_than]).created_at
    else
      newer_than = "2000-01-01".to_time
    end

    if params[:older_than]
      older_than = klass.find(params[:older_than]).created_at
    else
      older_than = "2100-01-01".to_time
    end

    if params[:group_id] == 'home'
      @feed_items = []
      for association in [:posts, :board_pics, :books]
        @feed_items += current_user.readable(association)
          .where('created_at > ?', newer_than).where('created_at < ?', older_than)
          .order('created_at DESC').limit(params[:count])
      end
    else
      group = Group.find(params[:group_id])
      authorize! :read, group
      @feed_items = []
      for association in [:posts, :board_pics, :books]
        @feed_items += group.send(association)
          .where('created_at > ?', newer_than).where('created_at < ?', older_than)
          .order('created_at DESC').limit(params[:count])
      end
    end
    @feed_items = @feed_items.sort{|a,b| a.created_at <=> b.created_at }
                  .reverse[0, params[:count]]
  end
end