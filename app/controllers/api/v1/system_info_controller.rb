class Api::V1::SystemInfoController < ApplicationController
  def time
    render :json => Time.now
  end
end