class GroupsController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource
  skip_load_and_authorize_resource :only => :show

  def show
    if params[:id] == "all"
      collection = current_user.readable_posts
    else
      group = Group.find_by_id(params[:id])
      authorize! :read, group
      collection = group.posts
    end
    respond_to do |format|
      format.js { render :layout => false, :partial => '/posts/post', 
        :collection => collection }
    end
  end

  def create
    respond_to do |format|
      format.js do
        if @group.save
          return render :layout => false, :partial => 'groups/group_admin', 
            :object => @group
        else
          render :text => @group.errors.full_messages[0], :status => 409
        end
      end
    end
  end

  def update
    @group.update_attributes(params[:group])
    respond_to do |format|
      format.json { respond_with_bip(@group) }
    end
  end

  def destroy
    @group.destroy
    respond_to do |format|
      format.js do
        render :nothing => true if @group.destroyed?
      end
    end
  end
end