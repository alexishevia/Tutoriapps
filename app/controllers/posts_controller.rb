class PostsController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource

  def create
    @post.author = current_user
    respond_to do |format|
      format.js do
        if @post.save
          render :layout => false, :partial => 'posts/post', 
            :object => @post
        else
          render :text => @post.errors.full_messages[0], :status => 409
        end
      end
    end
  end

end
