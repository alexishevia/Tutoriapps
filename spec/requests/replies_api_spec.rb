#coding: utf-8
require 'spec_helper'

describe "Replies V1 API" do
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
      :fisica => FactoryGirl.create(:group, :name => 'Física')
    }
    @groups[:fisica].members << @users[:fulano]

    3.times do
      FactoryGirl.create(:post, :group => @groups[:fisica])
    end

    @headers = {'HTTP_ACCEPT' => 'application/json'}
  end

  describe "GET /api/v1/posts/:post_id/replies" do
    describe "on success" do
      it "returns status code 200 (OK)"
      it "returns a JSON array with post's replies"
      it "returns each reply's id, text, and created_at"
      it "returns each relpy's author as an object with id and name"
      it "returns the array ordered by created_at, with the oldest first"
    end
    describe "when auth token is not valid or was not sent" do
      it "returns status code 401 (Unauthorized)"
      it "does not return the group's posts"
    end
    describe "when user is not member of the post's group" do
      it "returns status code 403 (Forbidden)" 
      it "does not return the post's replies" 
    end
    describe "when the post doesn't exist" do
      it "returns status code 404 (Not Found)"
    end
    describe "when the post has no replies" do
      it "returns status code 200 (OK)"
      it "returns a JSON empty array"
    end
    describe "when request format is not set to JSON" do
      it "returns status code 406 (Not Acceptable)"
      it "does not return the group's posts" 
    end
  end

  describe "POST /api/v1/posts/:post_id/replies" do

    describe "on success" do
      before(:all) { DatabaseCleaner.start }
      after(:all) { DatabaseCleaner.clean }
      before(:all) do
        @user = @users[:fulano]
        @group = @groups[:fisica]
        @post = @group.posts.first
        @replies_count = Reply.count
        @post_replies_count = @post.replies.count
        url = "/api/v1/posts/#{@post.id}/replies?auth_token=#{@user.authentication_token}"
        data = {:reply => FactoryGirl.attributes_for(:reply)}
        post url, data, @headers
        @status = response.status
      end
      it "returns status code 201 (Created)" do
        @status.should eq(201)
      end
      it "creates a new reply" do
        Reply.count.should be > @replies_count
      end
      it "reply is assigned to correct post" do
        @post.replies(false).count.should be > @post_replies_count
      end
      it "reply is assigned to token user" do
        @post.replies.last.author.should eq(@user)
      end
    end

    describe "when auth token is not valid or was not sent" do
      before(:all) do
        @group = @groups[:fisica]
        @post = @group.posts.first
        @replies_count = Reply.count
        data = {:reply => FactoryGirl.attributes_for(:reply)}
        url = "/api/v1/posts/#{@post.id}/replies?auth_token=invalid"
        post url, data, @headers
        @status1 = response.status
        url = "/api/v1/posts/#{@post.id}/replies"
        post url, data, @headers
        @status2 = response.status
      end
      it "returns status code 401 (Unauthorized)" do
        @status1.should eq(401)
        @status2.should eq(401)
      end
      it "does not create a new post" do
        Reply.count.should eq(@replies_count)
      end
    end

    describe "when user is not member of the post's group" do
      before(:all) do
        @user = @users[:mengano]
        @group = @groups[:fisica]
        @post = @group.posts.first
        @replies_count = Reply.count
        url = "/api/v1/posts/#{@post.id}/replies?auth_token=#{@user.authentication_token}"
        data = {:reply => FactoryGirl.attributes_for(:reply)}
        post url, data, @headers
        @status = response.status
      end
      it "returns status code 403 (Forbidden)" do
        @status.should eq(403)
      end
      it "does not create a new post" do
        Reply.count.should eq(@replies_count)
      end
    end

    describe "when the post doesn't exist" do
      before(:all) do
        @user = @users[:fulano]
        @replies_count = Reply.count
        url = "/api/v1/posts/999/replies?auth_token=#{@user.authentication_token}"
        data = {:reply => FactoryGirl.attributes_for(:reply)}
        post url, data, @headers
        @status = response.status
      end
      it "returns status code 404 (Not Found)" do
        @status.should eq(404)
      end
      it "does not create a new reply" do
        Reply.count.should eq(@replies_count)
      end
    end

    describe "when request format is not set to JSON" do
      before(:all) do
        headers = @headers.clone
        headers['HTTP_ACCEPT'] = 'text/html'
        @user = @users[:fulano]
        @group = @groups[:fisica]
        @post = @group.posts.first
        @replies_count = Reply.count
        url = "/api/v1/posts/#{@post.id}/replies?auth_token=#{@user.authentication_token}"
        data = {:reply => FactoryGirl.attributes_for(:reply)}
        post url, data, headers
        @status = response.status
      end
      it "returns status code 406 (Not Acceptable)" do
        @status.should eq(406)
      end
      it "does not create a new reply" do
        Reply.count.should eq(@replies_count)
      end
    end
    describe "when reply text is sent blank" do
      before(:all) do
        @user = @users[:fulano]
        @group = @groups[:fisica]
        @post = @group.posts.first
        @replies_count = Reply.count
        url = "/api/v1/posts/#{@post.id}/replies?auth_token=#{@user.authentication_token}"
        data = {:reply => FactoryGirl.attributes_for(:reply, :text => '')}
        post url, data, @headers
        @status = response.status
      end
      it "returns status code 422 (Unprocessable Entity)" do
        @status.should eq(422)
      end
      it "does not create a new reply" do
        Reply.count.should eq(@replies_count)
      end
    end
  end
end