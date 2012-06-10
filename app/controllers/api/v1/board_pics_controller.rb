class Api::V1::BoardPicsController < ApplicationController
  def create
    @board_pic = BoardPic.new(params[:board_pic])
    if @board_pic.save
      render :json => @board_pic, :status => :created
    else
      render :json => @post.errors.full_messages, :status => :unprocessable_entity
    end
  end
end