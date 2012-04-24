class PostsController < ApplicationController
  before_filter :authenticate_user!

  def create
    @group = Group.find(params[:group_id])
    @post = @group.posts.build(params[:post].merge(:user => current_user))
    if @post.save
      redirect_to @group
    else
      render '/groups/show'
    end
  end
end
