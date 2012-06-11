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
        @user = @users[:mengano]
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
      it "creates a new board_pic" do
        BoardPic.count.should be > @board_pics_count
      end
      it "saves the file correctly" do
        BoardPic.last.should have_attached_file(:image)
        BoardPic.last.image.url.scan('missing').length.should eq(0)
      end
      it "board_pic is assigned to token user" do
        BoardPic.last.author.should eq(@user)
      end
      it "board_pic is assigned to correct group" do
        BoardPic.last.group.should eq(@group)
      end
    end

    describe "when auth token is not valid or was not sent" do
      before(:all) do
        @user = @users[:mengano]
        @group = @groups[:fisica]
        @board_pics_count = BoardPic.count
        multipart = MultipartBody.new('board_pic[image]' => File.open("#{Rails.root}/spec/support/rails.png"))
        headers = @headers.clone
        headers['CONTENT_TYPE'] = "multipart/form-data; boundary=#{multipart.boundary}"
        data = multipart.to_s
        url = "/api/v1/groups/#{@group.id}/board_pics?auth_token=wrong"
        post url, data, headers
        @status1 = response.status
        url = "/api/v1/groups/#{@group.id}/board_pics"
        post url, data, headers
        @status2 = response.status
      end
      it "returns status code 401 (Unauthorized)" do
        @status1.should eq(401)
        @status2.should eq(401)
      end
      it "does not create a new board_pic" do
        BoardPic.count.should eq(@board_pics_count)
      end
    end

    describe "when user is not member of the group" do
      before(:all) do
        @user = @users[:mengano]
        @group = @groups[:calculo]
        @board_pics_count = BoardPic.count
        url = "/api/v1/groups/#{@group.id}/board_pics?auth_token=#{@user.authentication_token}"
        multipart = MultipartBody.new('board_pic[image]' => File.open("#{Rails.root}/spec/support/rails.png"))
        headers = @headers.clone
        headers['CONTENT_TYPE'] = "multipart/form-data; boundary=#{multipart.boundary}"
        data = multipart.to_s
        post url, data, headers
        @status = response.status
      end
      it "returns status code 403 (Forbidden)" do
        @status.should eq(403)
      end
      it "does not create a new board_pic" do
        BoardPic.count.should eq(@board_pics_count)
      end
    end

    describe "when the group doesn't exist" do
      before(:all) do
        @user = @users[:mengano]
        @board_pics_count = BoardPic.count
        url = "/api/v1/groups/999/board_pics?auth_token=#{@user.authentication_token}"
        multipart = MultipartBody.new('board_pic[image]' => File.open("#{Rails.root}/spec/support/rails.png"))
        headers = @headers.clone
        headers['CONTENT_TYPE'] = "multipart/form-data; boundary=#{multipart.boundary}"
        data = multipart.to_s
        post url, data, headers
        @status = response.status
      end
      it "returns status code 404 (Not Found)" do
        @status.should eq(404)
      end
      it "does not create a new board_pic" do
        BoardPic.count.should eq(@board_pics_count)
      end
    end

    describe "when group id is 'home'" do
      before(:all) do
        @user = @users[:mengano]
        @board_pics_count = BoardPic.count
        url = "/api/v1/groups/home/board_pics?auth_token=#{@user.authentication_token}"
        multipart = MultipartBody.new('board_pic[image]' => File.open("#{Rails.root}/spec/support/rails.png"))
        headers = @headers.clone
        headers['CONTENT_TYPE'] = "multipart/form-data; boundary=#{multipart.boundary}"
        data = multipart.to_s
        post url, data, headers
        @status = response.status
      end
      it "returns status code 422 (Unprocessable Entity)" do
        @status.should eq(422)
      end
      it "does not create a new board_pic" do
        BoardPic.count.should eq(@board_pics_count)
      end
    end

    describe "when request format is not set to JSON" do
      before(:all) do
        @user = @users[:mengano]
        @group = @groups[:fisica]
        @board_pics_count = BoardPic.count
        url = "/api/v1/groups/#{@group.id}/board_pics?auth_token=#{@user.authentication_token}"
        multipart = MultipartBody.new('board_pic[image]' => File.open("#{Rails.root}/spec/support/rails.png"))
        headers = @headers.clone
        headers['HTTP_ACCEPT'] = 'text/html'
        headers['CONTENT_TYPE'] = "multipart/form-data; boundary=#{multipart.boundary}"
        data = multipart.to_s
        post url, data, headers
        @status = response.status
      end
      it "returns status code 406 (Not Acceptable)" do
        @status.should eq(406)
      end
      it "does not create a new board_pic" do
        BoardPic.count.should eq(@board_pics_count)
      end
    end

    describe "when board_pic image is sent blank" do
      before(:all) do
        @user = @users[:mengano]
        @group = @groups[:fisica]
        @board_pics_count = BoardPic.count
        url = "/api/v1/groups/#{@group.id}/board_pics?auth_token=#{@user.authentication_token}"
        data = {:board_pic => {:image => nil}}
        post url, data, @headers
        @status = response.status
      end
      it "returns status code 422 (Unprocessable Entity)" do
        @status.should eq(422)
      end
      it "does not create a new board_pic" do
        BoardPic.count.should eq(@board_pics_count)
      end
    end
    describe "when board_pic[group_id] is set to another group" do
      before(:all) { DatabaseCleaner.start }
      after(:all) { DatabaseCleaner.clean }
      before(:all) do
        @user = @users[:mengano]
        @group = @groups[:fisica]
        @board_pics_count = BoardPic.count
        url = "/api/v1/groups/#{@group.id}/board_pics?auth_token=#{@user.authentication_token}"
        multipart = MultipartBody.new(
          'board_pic[image]' => File.open("#{Rails.root}/spec/support/rails.png"),
          'board_pic[group_id]' => @groups[:calculo].id
        )
        headers = @headers.clone
        headers['CONTENT_TYPE'] = "multipart/form-data; boundary=#{multipart.boundary}"
        data = multipart.to_s
        post url, data, headers
        @status = response.status
      end
      it "returns status code 201 (Created)" do
        @status.should eq(201)
      end
      it "creates a new board_pic" do
        BoardPic.count.should be > @board_pics_count
      end
      it "assigns the board_pic to group specified in url" do
        BoardPic.last.group.should eq(@group)
      end
    end
    describe "when board_pic[user_id] is set to another user" do
      before(:all) { DatabaseCleaner.start }
      after(:all) { DatabaseCleaner.clean }
      before(:all) do
        @user = @users[:mengano]
        @group = @groups[:fisica]
        @board_pics_count = BoardPic.count
        url = "/api/v1/groups/#{@group.id}/board_pics?auth_token=#{@user.authentication_token}"
        multipart = MultipartBody.new(
          'board_pic[image]' => File.open("#{Rails.root}/spec/support/rails.png"),
          'board_pic[user_id]' => @users[:fulano].id
        )
        headers = @headers.clone
        headers['CONTENT_TYPE'] = "multipart/form-data; boundary=#{multipart.boundary}"
        data = multipart.to_s
        post url, data, headers
        @status = response.status
      end
      it "returns status code 201 (Created)" do
        @status.should eq(201)
      end
      it "creates a new board_pic" do
        BoardPic.count.should be > @board_pics_count
      end
      it "creates the board_pic with author set to token owner" do
        BoardPic.last.author.should eq(@user)
      end
    end
  end
end