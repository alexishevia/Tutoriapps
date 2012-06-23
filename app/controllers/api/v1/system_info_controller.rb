class Api::V1::SystemInfoController < ApplicationController
  def time
    render :json => Time.now.utc.iso8601
  end
end