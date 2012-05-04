class PostsController < ApplicationController
  before_filter :authenticate_user!

  def create
    if params[:group_id]
      @group = Group.find(params[:group_id])
      authorize! :read, @group
      @post = @group.posts.build(params[:post].merge(:author => current_user))
      if @post.save
        redirect_to @group
      else
        render '/groups/show'
      end
    else
      @post = Post.new(params[:post].merge(:author => current_user))
      if @post.save
        redirect_to root_path
      else
        @groups = current_user.groups
        render '/home/home'
      end
    end    
  end
end
