#coding: utf-8
require 'spec_helper'

describe "Posts V1 API" do
  before(:all) do
    @users = {
      :fulano => FactoryGirl.create(:user, :email => 'fulano@utp.ac.pa'),
      :mengano => FactoryGirl.create(:user, :email => 'mengano@utp.ac.pa')
    }
    @users.each do |index, user| 
      user.confirmed_at = Time.now
      user.save
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

    3.times do
      FactoryGirl.create(:post, :group => @groups[:fisica])
    end

    @headers = {'HTTP_ACCEPT' => 'application/json'}
  end

  after(:all) do
    DatabaseCleaner.clean
  end
  
  describe "GET /api/v1/groups/:group_id/posts?auth_token=:token" do

    describe "on success" do
      before(:all) do
        token = @users[:fulano].authentication_token
        url = "/api/v1/groups/#{@groups[:fisica].id}/posts?auth_token=#{token}"
        get url, nil, @headers
        @status = response.status
        @data = JSON.parse(response.body)
      end
      it "returns status code 200" do
        @status.should eq(200)
      end
      it "returns a JSON array with group's posts" do
        for post in @data
          @groups[:fisica].posts.find(post["id"]).should be_true
        end
      end
      it "returns the post's id, text, and created_at" do
        for post in @data
          post["id"].should be_true
          post["text"].should be_true
          post["created_at"].should be_true
        end
      end
      it "returns the post's group as an object with id and name" do
        for post in @data
          post["group"]["id"].should be_true
          post["group"]["name"].should be_true
        end
      end
      it "returns the post's author as an object with id and name" do
        for post in @data
          post["author"]["id"].should be_true
          post["author"]["name"].should be_true
          post["author"]["name"].should be_true
        end
      end
    end
    
    describe "when auth token is not valid or was not sent" do
      before(:all) do
        url = "/api/v1/groups/#{@groups[:fisica].id}/posts?auth_token=wrong"
        get url, nil, @headers
        @status1 = response.status
        url = "/api/v1/groups/#{@groups[:fisica].id}/posts"
        get url, nil, @headers
        @status2 = response.status
      end
      it "returns status code 401 (Unauthorized)" do
        @status1.should eq(401)
        @status2.should eq(401)
      end
    end

    describe "when user is not member of the group" do
      before(:all) do
        group = @groups[:calculo]
        user = @users[:mengano]
        group.members.exists?(user).should be_false
        token = user.authentication_token
        url = "/api/v1/groups/#{group.id}/posts?auth_token=#{token}"
        get url, nil, @headers
        @status = response.status
      end
      it "returns status code 403 (Forbidden)" do
        @status.should eq(403)
      end
    end

    describe "when the group doesn't exist" do
      before(:all) do
        token = @users[:fulano].authentication_token
        url = "/api/v1/groups/unexistent/posts?auth_token=#{token}"
        get url, nil, @headers
        @status = response.status
      end
      it "returns status code 404 (Not Found)" do
        @status.should eq(404)
      end
    end
    
    describe "when group has no posts" do
      before(:all) do
        group = @groups[:calculo]
        group.posts.count.should eq(0)
        token = @users[:fulano].authentication_token
        url = "/api/v1/groups/#{group.id}/posts?auth_token=#{token}"
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
        url = "/api/v1/groups/#{@groups[:fisica].id}/posts?auth_token=#{token}"
        get url, nil, headers
        @status = response.status
      end
      it "returns status code 406 (Not Acceptable)" do
        @status.should eq(406)
      end
    end
  end

  describe "POST /api/v1/groups/:group_id/posts" do
    
  end

end