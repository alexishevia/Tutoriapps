#coding: utf-8
require 'spec_helper'

describe "Feed V1 API" do
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

    created_at = 30.days.ago
    5.times do
      FactoryGirl.create(:post, :group => @groups[:fisica], :created_at => created_at)
      created_at += 1.hour
      FactoryGirl.create(:reply, :post => @groups[:fisica].posts.last, :created_at => created_at)
      created_at += 1.hour
      FactoryGirl.create(:book, :group => @groups[:fisica], :created_at => created_at)
      created_at += 1.hour
      FactoryGirl.create(:board_pic, :group => @groups[:fisica], :created_at => created_at)
      created_at += 1.hour
    end

    @headers = {'HTTP_ACCEPT' => 'application/json'}
  end

  describe "GET /api/v1/groups/:group_id/all" do

    describe "on success" do
      before(:all) do
        token = @users[:fulano].authentication_token
        url = "/api/v1/groups/#{@groups[:fisica].id}/all?auth_token=#{token}"
        get url, nil, @headers
        @status = response.status
        @data = JSON.parse(response.body)
      end
      it "returns status code 200 (OK)" do
        @status.should eq(200)
      end
      it "returns a JSON array with the group's last 5 objects (combining posts, board_pics, and books)" do
        @data.class.should eq(Array)
        @data.length.should eq(5)
      end
      it "group's objects are ordered by creation date, with last created appearing first" do
        last_created_at = @data.first['data']['created_at']
        for object in @data
          object['data']['created_at'].should be <= last_created_at
          last_created_at = object['data']['created_at']
        end
      end
      it "every object in the array has a property 'type' which is either 'post', 'board_pic', or 'book'" do
        for object in @data
          object["type"].should be_true
          %w[post board_pic book].include?(object["type"]).should be_true
        end
      end
      it "every object in the array has a property 'data' which contains all data for the current object" do
        for object in @data
          object["data"].should be_true
          object["data"]["id"].should be_true
          object["data"]["created_at"].should be_true
          case object["type"]
          when "post"
            object["data"]["text"].should be_true
          when "board_pic"
            object["data"]["image"].should be_true
          when "book"
            object["data"]["title"].should be_true
          end
        end
      end
    end

    describe "with query params" do
      describe "?older_than=:datetime_as_utc_iso8601" do
        before(:all) do
          token = @users[:fulano].authentication_token
          @group = @groups[:fisica]
          @fifth = @group.content.sort{|a,b| a.created_at <=> b.created_at }.reverse[5]
          url = "/api/v1/groups/#{@group.id}/all?auth_token=#{token}"
          url += "&older_than=#{@fifth.created_at.utc.iso8601}"
          get url, nil, @headers
          @status = response.status
          @data = JSON.parse(response.body)
        end
        it "returns status code 200 (OK)" do
          @status.should eq(200)
        end
        it "returns a JSON array with group's objects older than the one sent" do
          @data.class.should eq(Array)
          for object in @data
            object["data"]["created_at"].to_time.should be <= @fifth.created_at
          end
        end
      end
      describe "?newer_than=:datetime_as_utc_iso8601" do
        before(:all) do
          token = @users[:fulano].authentication_token
          @group = @groups[:fisica]
          @fifth = @group.content.sort{|a,b| a.created_at <=> b.created_at }.reverse[5]
          url = "/api/v1/groups/#{@group.id}/all?auth_token=#{token}"
          url += "&newer_than=#{@fifth.created_at.utc.iso8601}"
          get url, nil, @headers
          @status = response.status
          @data = JSON.parse(response.body)
        end
        it "returns status code 200 (OK)" do
          @status.should eq(200)
        end
        it "returns a JSON array with group's objects newer than the one sent" do
          @data.class.should eq(Array)
          for object in @data
            object["data"]["created_at"].to_time.should be >= @fifth.created_at
          end
        end
      end
      describe "when older_than or newer_than is used but date is invalid" do
        before(:all) do
          token = @users[:fulano].authentication_token
          @group = @groups[:fisica]
          @fifth = @group.content.sort{|a,b| a.created_at <=> b.created_at }.reverse[5]
          url = "/api/v1/groups/#{@group.id}/all?auth_token=#{token}"
          url += "&older_than=invalid-date"
          get url, nil, @headers
          @status = response.status
          @data = JSON.parse(response.body)
        end
        it "returns status code 400 (Bad Request)" do
          @status.should eq(400)
        end
      end
      describe "?count=:N" do
        before(:all) do
          token = @users[:fulano].authentication_token
          @group = @groups[:fisica]
          @requests = [{:n => 3}, {:n => 8}, {:n => 15}]
          for request in @requests
            url = "/api/v1/groups/#{@group.id}/all?auth_token=#{token}"
            url += "&count=#{request[:n]}"
            get url, nil, @headers
            request[:status] = response.status
            request[:data] = JSON.parse(response.body)
          end
        end
        it "returns status code 200 (OK)" do
          for request in @requests
            request[:status].should eq(200)
          end
        end
        it "returns a JSON array with the group's last N objects (combining posts, board_pics, and books)" do
          for request in @requests
            request[:data].class.should eq(Array)
            request[:data].length.should eq(request[:n])
          end
        end
      end
      describe "?include_replies=1" do
        before(:all) do
          token = @users[:fulano].authentication_token
          @group = @groups[:fisica]
          url = "/api/v1/groups/#{@group.id}/all?auth_token=#{token}"
          url += "&include_replies=1"
          get url, nil, @headers
          @status = response.status
          @data = JSON.parse(response.body)
        end
        it "returns status code 200 (OK)" do
          @status.should eq(200)
        end
        it "includes replies along with posts, board_pics, and books" do
          count = Hash.new(0)
          for item in @data
            count[item["type"]] += 1
          end
          count["post"].should be > 0
          count["board_pic"].should be > 0
          count["book"].should be > 0
          count["reply"].should be > 0
        end
      end
    end

    describe "when auth token is not valid or was not sent" do
      before(:all) do
        url = "/api/v1/groups/#{@groups[:fisica].id}/all?auth_token=wrong"
        get url, nil, @headers
        @status1 = response.status
        @data1 = JSON.parse(response.body)
        url = "/api/v1/groups/#{@groups[:fisica].id}/all"
        get url, nil, @headers
        @status2 = response.status
        @data2 = JSON.parse(response.body)
      end
      it "returns status code 401 (Unauthorized)" do
        @status1.should eq(401)
        @status2.should eq(401)
      end
      it "does not return the group's objects" do
        @data1.class.should_not eq(Array)
        @data2.class.should_not eq(Array)
      end
    end

    describe "when user is not member of the group" do
      before(:all) do
        group = @groups[:calculo]
        user = @users[:mengano]
        group.members.exists?(user).should be_false
        token = user.authentication_token
        url = "/api/v1/groups/#{group.id}/all?auth_token=#{token}"
        get url, nil, @headers
        @status = response.status
      end
      it "returns status code 403 (Forbidden)" do
        @status.should eq(403)
      end
      it "does not return the group's objects" do
        @data.class.should_not eq(Array)
      end
    end

    describe "when the group doesn't exist" do
      before(:all) do
        token = @users[:fulano].authentication_token
        url = "/api/v1/groups/unexistent/all?auth_token=#{token}"
        get url, nil, @headers
        @status = response.status
      end
      it "returns status code 404 (Not Found)" do
        @status.should eq(404)
      end
    end

    describe "when group has no objects" do
      before(:all) do
        group = @groups[:calculo]
        group.content.count.should eq(0)
        token = @users[:fulano].authentication_token
        url = "/api/v1/groups/#{group.id}/all?auth_token=#{token}"
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
        token = @users[:fulano].authentication_token
        url = "/api/v1/groups/#{@groups[:fisica].id}/all?auth_token=#{token}"
        get url, nil, headers
        @status = response.status
      end
      it "returns status code 406 (Not Acceptable)" do
        @status.should eq(406)
      end
      it "does not return the group's objects" do
        @data.class.should_not eq(Array)
      end
    end
  end
end