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

    15.times do
      FactoryGirl.create(:board_pic, :group => @groups[:fisica])
      FactoryGirl.create(:board_pic, :group => @groups[:calculo])
    end

    @headers = {'HTTP_ACCEPT'  => 'application/json'}
  end

  describe "GET /api/v1/groups/:group_id/board_pics" do

    describe "on success" do
      before(:all) do
        @user = @users[:mengano]
        @group = @groups[:fisica]
        url = "/api/v1/groups/#{@group.id}/board_pics?auth_token=#{@user.authentication_token}"
        get url, nil, @headers
        @status = response.status
        @data = JSON.parse(response.body)
      end
      it "returns status code 200 (OK)" do
        @status.should eq(200)
      end
      it "returns a JSON array with group's last 10 board_pics (ordered by class_date)" do
        @data.class.should eq(Array)
        @data.length.should eq(10)
        @data.detect { |bp| bp["id"] == @group.board_pics.order('class_date DESC').first.id }
          .should be_true
        for board_pic in @data
          @group.board_pics.where(:id => board_pic["id"]).count.should eq(1)
        end
      end
      it "group's board_pics are ordered by class_date, with newest date appearing first" do
        last_class_date = @data.first['class_date']
        for board_pic in @data
          board_pic['class_date'].should be <= last_class_date
          last_class_date = board_pic['class_date']
        end
      end
      it "returns each board_pic's id, class_date, and created_at" do
        for board_pic in @data
          board_pic["id"].should be_true
          board_pic["class_date"].should be_true
          board_pic["created_at"].should be_true
        end
      end
      it "returns each board_pic's image as an object with url, thumbnail_url, size and content_type" do
        for board_pic in @data
          board_pic["image"]["url"].should be_true
          board_pic["image"]["thumbnail_url"].should be_true
          board_pic["image"]["size"].should be_true
          board_pic["image"]["content_type"].should be_true
        end
      end
      it "returns each board_pic's author as an object with id and name" do
        for board_pic in @data
          board_pic["author"]["id"].should be_true
          board_pic["author"]["name"].should be_true
          board_pic["author"]["name"].should be_true
        end
      end
    end

    describe "when paging query params are sent" do
      describe "?page=1&per_page=5" do
        before(:all) do
          @user = @users[:mengano]
          @group = @groups[:fisica]
          url = "/api/v1/groups/#{@group.id}/board_pics"
          url += "?auth_token=#{@user.authentication_token}&page=1&per_page=5"
          get url, nil, @headers
          @status = response.status
          @data = JSON.parse(response.body)
        end
        it "returns status code 200 (OK)" do
          @status.should eq(200)
        end
        it "returns a JSON array with group's last 5 board_pics (ordered by class_date)" do
          @data.class.should eq(Array)
          @data.length.should eq(5)
          for board_pic in @group.board_pics.order('class_date DESC').limit(5)
            @data.detect { |bp| bp["id"] == board_pic.id }.should be_true
          end
        end
      end
      describe "?page=2&per_page=3" do
        before(:all) do
          @user = @users[:mengano]
          @group = @groups[:fisica]
          url = "/api/v1/groups/#{@group.id}/board_pics"
          url += "?auth_token=#{@user.authentication_token}&page=2&per_page=3"
          get url, nil, @headers
          @status = response.status
          @data = JSON.parse(response.body)
        end
        it "returns status code 200 (OK)" do
          @status.should eq(200)
        end
        it "returns a JSON array with group's board_pics from 4 to 6 (ordered by class_date)" do
          @data.class.should eq(Array)
          @data.length.should eq(3)
          for board_pic in @group.board_pics.order('class_date DESC').limit(3).offset(3)
            @data.detect { |bp| bp["id"] == board_pic.id }.should be_true
          end
        end
      end
    end

    describe "when group_id is 'home'" do
      before(:all) do
        @user = @users[:mengano]
        url = "/api/v1/groups/home/board_pics?auth_token=#{@user.authentication_token}"
        get url, nil, @headers
        @status = response.status
        @data = JSON.parse(response.body)
      end
      it "returns status code 400 (Bad Request)" do
        @status.should eq(400)
      end
      it "does not return the group's board_pics" do
        @data.class.should_not eq(Array)
      end
    end

    describe "when auth token is not valid or was not sent" do
      before(:all) do
        @user = @users[:mengano]
        @group = @groups[:fisica]
        url = "/api/v1/groups/#{@group.id}/board_pics?auth_token=invalid"
        get url, nil, @headers
        @status1 = response.status
        @data1 = JSON.parse(response.body)
        url = "/api/v1/groups/#{@group.id}/board_pics?auth_token=invalid"
        get url, nil, @headers
        @status2 = response.status
        @data2 = JSON.parse(response.body)
      end
      it "returns status code 401 (Unauthorized)" do
        @status1.should eq(401)
        @status2.should eq(401)
      end
      it "does not return the group's board_pics" do
        @data1.class.should_not eq(Array)
        @data2.class.should_not eq(Array)
      end
    end

    describe "when user is not member of the group" do
      before(:all) do
        @user = @users[:mengano]
        @group = @groups[:calculo]
        url = "/api/v1/groups/#{@group.id}/board_pics?auth_token=#{@user.authentication_token}"
        get url, nil, @headers
        @status = response.status
        @data = JSON.parse(response.body)
      end
      it "returns status code 403 (Forbidden)" do
        @status.should eq(403)
      end
      it "does not return the group's board_pics" do
        @data.class.should_not eq(Array)
      end
    end

    describe "when the group doesn't exist" do
      before(:all) do
        @user = @users[:mengano]
        url = "/api/v1/groups/999/board_pics?auth_token=#{@user.authentication_token}"
        get url, nil, @headers
        @status = response.status
        @data = JSON.parse(response.body)
      end
      it "returns status code 404 (Not Found)" do
        @status.should eq(404)
      end
    end

    describe "when group has no board_pics" do
      before(:all) { DatabaseCleaner.start }
      after(:all) { DatabaseCleaner.clean }
      before(:all) do
        @user = @users[:mengano]
        @group = @groups[:fisica]
        @group.board_pics.destroy_all
        url = "/api/v1/groups/#{@group.id}/board_pics?auth_token=#{@user.authentication_token}"
        get url, nil, @headers
        @status = response.status
        @data = JSON.parse(response.body)
      end
      it "returns status code 200 (OK)" do
        @status.should eq(200)
      end
      it "returns a JSON empty array" do
        @data.should eq([])
      end
    end

    describe "when request format is not set to JSON" do
      before(:all) do
        headers = @headers.clone
        headers['HTTP_ACCEPT'] = 'text/html'
        @user = @users[:mengano]
        @group = @groups[:fisica]
        url = "/api/v1/groups/#{@group.id}/board_pics?auth_token=#{@user.authentication_token}"
        get url, nil, headers
        @status = response.status
        @data = JSON.parse(response.body)
      end
      it "returns status code 406 (Not Acceptable)" do
        @status.should eq(406)
      end
      it "does not return the group's board_pics" do
        @data.class.should_not eq(Array)
      end
    end

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
        multipart = MultipartBody.new(
          'board_pic[image]' => File.open("#{Rails.root}/spec/support/rails.png"),
          'board_pic[class_date]' => '2012-06-01'
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
        multipart = MultipartBody.new(
          'board_pic[image]' => File.open("#{Rails.root}/spec/support/rails.png"),
          'board_pic[class_date]' => '2012-06-01'
        )
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
        multipart = MultipartBody.new(
          'board_pic[image]' => File.open("#{Rails.root}/spec/support/rails.png"),
          'board_pic[class_date]' => '2012-06-01'
        )
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
        multipart = MultipartBody.new(
          'board_pic[image]' => File.open("#{Rails.root}/spec/support/rails.png"),
          'board_pic[class_date]' => '2012-06-01'
        )
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
        multipart = MultipartBody.new(
          'board_pic[image]' => File.open("#{Rails.root}/spec/support/rails.png"),
          'board_pic[class_date]' => '2012-06-01'
        )
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
        multipart = MultipartBody.new(
          'board_pic[image]' => File.open("#{Rails.root}/spec/support/rails.png"),
          'board_pic[class_date]' => '2012-06-01'
        )
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

    describe "when board_pic image is not sent" do
      before(:all) do
        @user = @users[:mengano]
        @group = @groups[:fisica]
        @board_pics_count = BoardPic.count
        url = "/api/v1/groups/#{@group.id}/board_pics?auth_token=#{@user.authentication_token}"
        multipart = MultipartBody.new(
          'board_pic[class_date]' => '2012-06-01'
        )
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

    describe "when board_pic class_date is not sent" do
      before(:all) do
        @user = @users[:mengano]
        @group = @groups[:fisica]
        @board_pics_count = BoardPic.count
        url = "/api/v1/groups/#{@group.id}/board_pics?auth_token=#{@user.authentication_token}"
        multipart = MultipartBody.new(
          'board_pic[image]' => File.open("#{Rails.root}/spec/support/rails.png")
        )
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

    describe "when board_pic class_date is not valid" do
      before(:all) do
        @user = @users[:mengano]
        @group = @groups[:fisica]
        @board_pics_count = BoardPic.count
        url = "/api/v1/groups/#{@group.id}/board_pics?auth_token=#{@user.authentication_token}"
        multipart = MultipartBody.new(
          'board_pic[image]' => File.open("#{Rails.root}/spec/support/rails.png"),
          'board_pic[class_date]' => '2012-06-32'
        )
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

    describe "when board_pic group_id is set to another group" do
      before(:all) { DatabaseCleaner.start }
      after(:all) { DatabaseCleaner.clean }
      before(:all) do
        @user = @users[:mengano]
        @group = @groups[:fisica]
        @board_pics_count = BoardPic.count
        url = "/api/v1/groups/#{@group.id}/board_pics?auth_token=#{@user.authentication_token}"
        multipart = MultipartBody.new(
          'board_pic[image]' => File.open("#{Rails.root}/spec/support/rails.png"),
          'board_pic[class_date]' => '2012-06-1',
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
    describe "when board_pic user_id is set to another user" do
      before(:all) { DatabaseCleaner.start }
      after(:all) { DatabaseCleaner.clean }
      before(:all) do
        @user = @users[:mengano]
        @group = @groups[:fisica]
        @board_pics_count = BoardPic.count
        url = "/api/v1/groups/#{@group.id}/board_pics?auth_token=#{@user.authentication_token}"
        multipart = MultipartBody.new(
          'board_pic[image]' => File.open("#{Rails.root}/spec/support/rails.png"),
          'board_pic[class_date]' => '2012-06-1',
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