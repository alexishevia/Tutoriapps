#coding: utf-8
require 'spec_helper'

describe "Board Pics V1 API" do
  before(:all) do
    @users = {
      :fulano => FactoryGirl.create(:user),
      :mengano => FactoryGirl.create(:user)
    }
    @users.each do |index, user| 
      user.confirmed_at = Time.now
      user.save!
      user.reset_authentication_token!
      user.reload
    end
    @groups = {
      :fisica => FactoryGirl.create(:group, :name => 'Física'),
      :calculo => FactoryGirl.create(:group, :name => 'Cálculo')
    }
    
    @groups[:fisica].members << @users[:fulano]
    @groups[:fisica].members << @users[:mengano]
    @groups[:calculo].members << @users[:fulano]

    @headers = {'HTTP_ACCEPT'  => 'application/json'}
  end

  describe "POST /api/v1/groups/:group_id/board_pics" do
    describe "on success" do
      before(:all) { DatabaseCleaner.start }
      after(:all) { DatabaseCleaner.clean }
      before(:all) do
        @user = @users[:fulano]
        @group = @groups[:fisica]
        @board_pics_count = BoardPic.count
        url = "/api/v1/groups/#{@group.id}/board_pics?auth_token=#{@user.authentication_token}"
        multipart = MultipartBody.new('board_pic[image]' => File.open("#{Rails.root}/spec/support/rails.png"))
        headers = @headers.clone
        headers['CONTENT_TYPE'] = "multipart/form-data; boundary=#{multipart.boundary}"
        data = multipart.to_s
        post url, data, headers
        @status = response.status
      end
      it "returns status code 201 (Created)" do
        @status.should eq(201)
      end
      it "creates a new board_pic in the group" do
        BoardPic.count.should be > @board_pics_count
      end
      it "saves the file correctly" do
        BoardPic.last.should have_attached_file(:image)
        BoardPic.last.image.url.scan('missing').length.should eq(0)
        debugger
        0
      end
      it "board_pic is assigned to token user"
    end
  end
end