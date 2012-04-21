class GroupsController < ApplicationController

  def show
    @group = Group.find(params[:id])
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(params[:group])
    if @group.save
      redirect_to @group, :notice => I18n.t('helpers.messages.created', 
        :model => I18n.t('group'))
    else
      render :action => 'new'
    end
  end
end