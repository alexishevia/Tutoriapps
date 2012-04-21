class GroupsController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource

  def show
  end

  def new
  end

  def create
    if @group.save
      redirect_to @group, :notice => I18n.t('helpers.messages.created', 
        :model => I18n.t('group'))
    else
      render :action => 'new'
    end
  end
end