class GroupsController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource

  def show
    @post = @group.posts.build
  end

  def new
  end

  def create
    if @group.save
      redirect_to @group, :notice => I18n.t('helpers.messages.created', 
        :model => I18n.t('activerecord.models.group'))
    else
      render :action => 'new'
    end
  end
end