#coding: utf-8
require 'spec_helper'

describe "Groups V1 API" do
  before(:all) do 
    @users = {
      :fulano => FactoryGirl.create(:user),
      :mengano => FactoryGirl.create(:user),
      :admin => FactoryGirl.create(:user)
    }
    @users.each do |key, user| 
      user.confirmed_at = Time.now
      user.admin = (key == :admin)
      user.save!
      user.reset_authentication_token!
      user.reload
    end

    @groups = {
      :fisica => FactoryGirl.create(:group, :name => 'Física'),
      :calculo => FactoryGirl.create(:group, :name => 'Cálculo')
    }
    @groups[:fisica].members << @users[:fulano]
    @groups[:calculo].members << @users[:fulano]

    @headers = {'HTTP_ACCEPT' => 'application/json'}  
  end

  describe "GET /api/v1/groups" do
    describe "on success" do
      before(:all) do
        token = @users[:fulano].authentication_token
        url = "/api/v1/groups?auth_token=#{token}"
        get url, nil, @headers
        @status = response.status
        @data = JSON.parse(response.body)
      end
      it "returns status code 200 (OK)" do
        @status.should eq(200)
      end
      it "returns a JSON array with user groups" do
        @data.class.should eq(Array)
        for group in @data
          next if group["id"] == 'home'
          @users[:fulano].groups.where('group_id = ?', group["id"]).count.should eq(1)
        end
      end
      it "JSON array contains 'home' group" do
        @data.count{|group| group["id"] == 'home'}.should eq(1)
      end
      it "returns each group's name and id" do
        for group in @data
          group["name"].should be_true
          group["id"].should be_true          
        end
      end
      it "returns each group's enrollments as an array" do
        for group in @data
          group["enrollments"].class.should eq(Array)
        end
      end
    end
    describe "when auth token is not valid or was not sent" do
      before(:all) do
        url = "/api/v1/groups"
        get url, nil, @headers
        @status1 = response.status
        url = "/api/v1/groups?auth_token=invalid"
        get url, nil, @headers
        @status2 = response.status
      end
      it "returns status code 401 (Unauthorized)" do
        @status1.should eq(401)
        @status2.should eq(401)
      end
    end
    describe "when user has no groups" do
      before(:all) do
        token = @users[:mengano].authentication_token
        url = "/api/v1/groups?auth_token=#{token}"
        get url, nil, @headers
        @status = response.status
        @data = JSON.parse(response.body)
      end
      it "returns status code 200 (OK)" do
        @status.should eq(200)
      end
      it "returns an array with 'home' group" do
        @data.class.should eq(Array)
        @data.length.should eq(1)
        @data[0]["id"].should eq('home')
      end
    end
    describe "when request format is not set to JSON" do
      before(:all) do
        headers = @headers.clone
        headers['HTTP_ACCEPT'] = 'text/html'
        token = @users[:fulano].authentication_token
        url = "/api/v1/groups?auth_token=#{token}"
        get url, nil, headers
        @status = response.status
        @data = JSON.parse(response.body)
      end
      it "returns status code 406 (Not Acceptable)" do
        @status.should eq(406)
      end
      it "does not return the user's groups" do
        @data.class.should_not eq(Array)
      end
    end
  end

  describe "POST /api/v1/groups" do
    describe "on success" do
      before(:all) { DatabaseCleaner.start }
      after(:all) { DatabaseCleaner.clean }
      before(:all) do
        user = @users[:admin]
        @group_count = Group.count
        url = "/api/v1/groups?auth_token=#{user.authentication_token}"
        data = {:group => FactoryGirl.attributes_for(:group)}
        post url, data, @headers
        @status = response.status
      end
      it "returns status code 201 (Created)" do
        @status.should eq(201)
      end
      it "creates a new group" do
        Group.count.should be > @group_count
      end
    end
    describe "when request format is not set to JSON" do
      before(:all) do
        headers = @headers.clone
        headers['HTTP_ACCEPT'] = 'text/html'
        user = @users[:admin]
        @group_count = Group.count
        url = "/api/v1/groups?auth_token=#{user.authentication_token}"
        data = {:group => FactoryGirl.attributes_for(:group)}
        post url, data, headers
        @status = response.status
      end
      it "returns status code 406 (Not Acceptable)" do
        @status.should eq(406)
      end
      it "does not create a new group" do
        Group.count.should eq(@group_count)
      end
    end
    describe "when user is not admin" do
      before(:all) do
        user = @users[:fulano]
        @group_count = Group.count
        url = "/api/v1/groups?auth_token=#{user.authentication_token}"
        data = {:group => FactoryGirl.attributes_for(:group)}
        post url, data, @headers
        @status = response.status
      end
      it "returns status code 403 (Forbidden)" do
        @status.should eq(403)
      end
      it "does not create a new group" do
        Group.count.should eq(@group_count)
      end
    end
  end

  describe "PUT /api/v1/groups/:id" do
    describe "on success" do
      before(:all) { DatabaseCleaner.start }
      after(:all) { DatabaseCleaner.clean; }
      before(:all) do
        user = @users[:admin]
        @group = @groups[:calculo]
        @old_name = @group.name
        @new_name = 'New name'
        url = "/api/v1/groups/#{@group.id}?auth_token=#{user.authentication_token}"
        data = {:group => {:name => @new_name}}
        put url, data, @headers
        @status = response.status
      end
      it "returns status code 200 (OK)" do
        @status.should eq(200)
      end
      it "updates group" do
        @group.reload.name.should eq(@new_name)
      end
    end
    describe "when request format is not set to JSON" do
      before(:all) do
        headers = @headers.clone
        headers['HTTP_ACCEPT'] = 'text/html'
        user = @users[:admin]
        @group = @groups[:calculo].reload
        @old_name = @group.name
        @new_name = 'New name'
        url = "/api/v1/groups/#{@group.id}?auth_token=#{user.authentication_token}"
        data = {:group => {:name => @new_name}}
        put url, data, headers
        @status = response.status
      end
      it "returns status code 406 (Not Acceptable)" do
        @status.should eq(406)
      end
      it "does not update group" do
        @group.reload.name.should eq(@old_name)
      end
    end
    describe "when user is not admin" do
      before(:all) do
        user = @users[:fulano]
        @group = @groups[:calculo]
        @old_name = @group.name
        @new_name = 'New name'
        url = "/api/v1/groups/#{@group.id}?auth_token=#{user.authentication_token}"
        data = {:group => {:name => @new_name}}
        put url, data, @headers
        @status = response.status
      end
      it "returns status code 403 (Forbidden)" do
        @status.should eq(403)
      end
      it "does not update group" do
        @group.reload.name.should eq(@old_name)
      end
    end
    describe "when group does not exist" do
      before(:all) do
        user = @users[:admin]
        @new_name = 'New name'
        url = "/api/v1/groups/inexistent?auth_token=#{user.authentication_token}"
        data = {:group => {:name => @new_name}}
        put url, data, @headers
        @status = response.status
      end
      it "returns status code 404 (Not Found)" do
        @status.should eq(404)
      end
    end
    describe "when 'home' id is sent" do
      before(:all) do
        user = @users[:admin]
        @new_name = 'New name'
        url = "/api/v1/groups/home?auth_token=#{user.authentication_token}"
        data = {:group => {:name => @new_name}}
        put url, data, @headers
        @status = response.status
      end
      it "returns status code 404 (Not Found)" do
        @status.should eq(404)
      end
    end
  end

  describe "DELETE /api/v1/groups" do
    describe "on success" do
      before(:all) { DatabaseCleaner.start }
      after(:all) { DatabaseCleaner.clean }
      before(:all) do
        user = @users[:admin]
        @group = @groups[:calculo]
        @group_id = @group.id
        url = "/api/v1/groups/#{@group.id}?auth_token=#{user.authentication_token}"
        delete url, nil, @headers
        @status = response.status
      end
      it "returns status code 200 (OK)" do
        @status.should eq(200)
      end
      it "deletes group" do
        Group.find_by_id(@group_id).should be_false
      end
    end
    describe "when request format is not set to JSON" do
      before(:all) do
        headers = @headers.clone
        headers['HTTP_ACCEPT'] = 'text/html'
        user = @users[:admin]
        @group = @groups[:calculo]
        @group_id = @group.id
        url = "/api/v1/groups/#{@group.id}?auth_token=#{user.authentication_token}"
        delete url, nil, headers
        @status = response.status
      end
      it "returns status code 406 (Not Acceptable)" do
        @status.should eq(406)
      end
      it "does not delete group" do
        Group.find_by_id(@group_id).should be_true
      end
    end
    describe "when user is not admin" do
      it "returns status code 403 (Forbidden)"
      it "does not delete group"
    end
  end
end