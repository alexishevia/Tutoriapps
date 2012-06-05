#coding: utf-8
require 'spec_helper'

describe "Posts V1 API" do
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

    3.times do
      FactoryGirl.create(:post, :group => @groups[:fisica])
    end

    @headers = {'HTTP_ACCEPT' => 'application/json'}
  end
  
  describe "GET /api/v1/groups/:group_id/posts" do

    describe "on success" do
      before(:all) do
        token = @users[:fulano].authentication_token
        url = "/api/v1/groups/#{@groups[:fisica].id}/posts?auth_token=#{token}"
        get url, nil, @headers
        @status = response.status
        @data = JSON.parse(response.body)
      end
      it "returns status code 200 (OK)" do
        @status.should eq(200)
      end
      it "returns a JSON array with group's posts" do
        @data.class.should eq(Array)
        for post in @data
          @groups[:fisica].posts.where(:id => post["id"]).count.should eq(1)
        end
      end
      it "returns each post's id, text, and created_at" do
        for post in @data
          post["id"].should be_true
          post["text"].should be_true
          post["created_at"].should be_true
        end
      end
      it "returns each post's group as an object with id and name" do
        for post in @data
          post["group"]["id"].should be_true
          post["group"]["name"].should be_true
        end
      end
      it "returns each post's author as an object with id and name" do
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
        @data1 = JSON.parse(response.body)
        url = "/api/v1/groups/#{@groups[:fisica].id}/posts"
        get url, nil, @headers
        @status2 = response.status
        @data2 = JSON.parse(response.body)
      end
      it "returns status code 401 (Unauthorized)" do
        @status1.should eq(401)
        @status2.should eq(401)
      end
      it "does not return the group's posts" do
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
        url = "/api/v1/groups/#{group.id}/posts?auth_token=#{token}"
        get url, nil, @headers
        @status = response.status
      end
      it "returns status code 403 (Forbidden)" do
        @status.should eq(403)
      end
      it "does not return the group's posts" do
        @data.class.should_not eq(Array)
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
      it "does not return the group's posts" do
        @data.class.should_not eq(Array)
      end
    end
  end

  describe "POST /api/v1/groups/:group_id/posts" do
    describe "on success" do
      before(:all) { DatabaseCleaner.start }
      after(:all) { DatabaseCleaner.clean }
      before(:all) do
        @user = @users[:fulano]
        @group = @groups[:fisica]
        @group_post_count = @group.posts.count
        url = "/api/v1/groups/#{@group.id}/posts?auth_token=#{@user.authentication_token}"
        data = {:post => FactoryGirl.attributes_for(:post)}
        post url, data, @headers
        @status = response.status
      end
      it "returns status code 201 (Created)" do
        @status.should eq(201)
      end
      it "creates a new post in the group" do
        @group.posts(false).count.should be > @group_post_count
      end
      it "post is assigned to token user" do
        @group.posts.last.author.should eq(@user)
      end
    end

    describe "when user is not member of the group" do
      before(:all) do
        user = @users[:mengano]
        group = @groups[:calculo]
        group.members.exists?(user).should be_false
        @global_post_count = Post.count
        url = "/api/v1/groups/#{group.id}/posts?auth_token=#{user.authentication_token}"
        data = {:post => FactoryGirl.attributes_for(:post)}
        post url, data, @headers
        @status = response.status
      end
      it "returns status code 403 (Forbidden)" do
        @status.should eq(403)
      end
      it "does not create a new post" do
        Post.count.should eq(@global_post_count)
      end
    end

    describe "when the group doesn't exist" do
      before(:all) do
        user = @users[:fulano]
        @global_post_count = Post.count
        url = "/api/v1/groups/unexistent/posts?auth_token=#{user.authentication_token}"
        data = {:post => FactoryGirl.attributes_for(:post)}
        post url, data, @headers
        @status = response.status
      end
      it "returns status code 404 (Not Found)" do
        @status.should eq(404)
      end
      it "does not create a new post" do
        Post.count.should eq(@global_post_count)
      end
    end

    describe "when group id is 'home'" do
      before(:all) { DatabaseCleaner.start }
      after(:all) { DatabaseCleaner.clean }
      before(:all) do
        user = @users[:fulano]
        @global_post_count = Post.count
        url = "/api/v1/groups/home/posts?auth_token=#{user.authentication_token}"
        data = {:post => FactoryGirl.attributes_for(:post)}
        post url, data, @headers
        @status = response.status
      end
      it "returns status code 201 (created)" do
        @status.should eq(201)
      end
      it "creates a new public post" do
        Post.count.should be > @global_post_count
        Post.last.group.should be_false
      end
    end

    describe "when request format is not set to JSON" do
      before(:all) do
        headers = @headers.clone
        headers['HTTP_ACCEPT'] = 'text/html'
        user = @users[:fulano]
        group = @groups[:fisica]
        @global_post_count = Post.count
        url = "/api/v1/groups/#{group.id}/posts?auth_token=#{user.authentication_token}"
        data = {:post => FactoryGirl.attributes_for(:post)}
        post url, data, headers
        @status = response.status
      end
      it "returns status code 406 (Not Acceptable)" do
        @status.should eq(406)
      end
      it "does not create a new post" do
        Post.count.should eq(@global_post_count)
      end
    end

    describe "when post text is sent blank" do
      before(:all) do
        user = @users[:fulano]
        group = @groups[:fisica]
        @global_post_count = Post.count
        url = "/api/v1/groups/#{group.id}/posts?auth_token=#{user.authentication_token}"
        data = {:post => FactoryGirl.attributes_for(:post).merge({:text => ''})}
        post url, data, @headers
        @status = response.status
      end
      it "returns status code 422 (Unprocessable Entity)" do
        @status.should eq(422)
      end
      it "does not create a new post" do
        Post.count.should eq(@global_post_count)
      end
    end

    describe "when post[group_id] is set to another group" do
      before(:all) { DatabaseCleaner.start }
      after(:all) { DatabaseCleaner.clean }
      before(:all) do
        user = @users[:fulano]
        @group = @groups[:fisica]
        other_group = @groups[:calculo]
        @group_post_count = @group.posts.count
        url = "/api/v1/groups/#{@group.id}/posts?auth_token=#{user.authentication_token}"
        data = {:post => FactoryGirl.attributes_for(:post)
          .merge({:group_id => other_group.id})}
        post url, data, @headers
        @status = response.status
      end
      it "returns status code 201 (Created)" do
        @status.should eq(201)
      end
      it "creates the post with group from url" do
        @group.posts.count.should be > @group_post_count
        @group.posts.last.group.should eq(@group) 
      end
    end
    describe "when post[user] is set to another user" do
      before(:all) { DatabaseCleaner.start }
      after(:all) { DatabaseCleaner.clean }
      before(:all) do
        @user = @users[:fulano]
        other_user = @users[:mengano]
        @group = @groups[:fisica]
        @group_post_count = @group.posts.count
        url = "/api/v1/groups/#{@group.id}/posts?auth_token=#{@user.authentication_token}"
        data = {:post => FactoryGirl.attributes_for(:post)
          .merge({:user_id => other_user.id})}
        post url, data, @headers
        @status = response.status
      end
      it "creates the post with author set to current_user" do
        @group.posts.count.should be > @group_post_count
        @group.posts.last.author.should eq(@user) 
      end
    end
  end

end