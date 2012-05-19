class Api::V1::Admin::GroupsController < ApplicationController
  before_filter :authenticate_admin!
  respond_to :json

  def index
    @groups = Group.all
  end
end