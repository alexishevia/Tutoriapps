#coding: utf-8
require 'spec_helper'

describe "Enrollments V1 API" do
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

    @headers = {'HTTP_ACCEPT' => 'application/json'}  
  end

  describe "POST /api/v1/enrollments" do
    describe "on success" do
      before(:all) { DatabaseCleaner.start }
      after(:all) { DatabaseCleaner.clean }
      before(:all) do
        admin = @users[:admin]
        @group = @groups[:fisica]
        @user = @users[:fulano]
        @enrollments_count = Enrollment.count
        url = "/api/v1/enrollments?auth_token=#{admin.authentication_token}"
        data = {:enrollment => {:group_id => @group.id, :user_id => @user.id}}
        post url, data, @headers
        @status = response.status
      end
      it "returns status code 201 (Created)" do
        @status.should eq(201)
      end
      it "creates a new enrollment" do
        Enrollment.count.should be > @enrollments_count
      end
      it "assigns the user to the correct group" do
        @group.members.exists?(@user).should be_true
      end
    end
    describe "when existing user_id is sent" do
      before(:all) { DatabaseCleaner.start }
      after(:all) { DatabaseCleaner.clean }
      before(:all) do
        admin = @users[:admin]
        @group = @groups[:fisica]
        @user = @users[:fulano]
        @enrollments_count = Enrollment.count
        url = "/api/v1/enrollments?auth_token=#{admin.authentication_token}"
        data = {:enrollment => {:group_id => @group.id, :user_id => @user.id}}
        post url, data, @headers
        @status = response.status
      end
      it "returns status code 201 (Created)" do
        @status.should eq(201)
      end
      it "creates a new enrollment" do
        Enrollment.count.should be > @enrollments_count
      end
      it "assigns the user to the correct group" do
        @group.members.exists?(@user).should be_true
      end
    end
    describe "when existing user_email is sent" do
      before(:all) { DatabaseCleaner.start }
      after(:all) { DatabaseCleaner.clean }
      before(:all) do
        admin = @users[:admin]
        @group = @groups[:fisica]
        @user = @users[:fulano]
        @enrollments_count = Enrollment.count
        url = "/api/v1/enrollments?auth_token=#{admin.authentication_token}"
        data = {:enrollment => {:group_id => @group.id, :user_email => @user.email}}
        post url, data, @headers
        @status = response.status
      end
      it "returns status code 201 (Created)" do
        @status.should eq(201)
      end
      it "creates a new enrollment" do
        Enrollment.count.should be > @enrollments_count
      end
      it "assigns the user to the correct group" do
        @group.members.exists?(@user).should be_true
      end
    end
    describe "when non-existing user_email is sent" do
      before(:all) { DatabaseCleaner.start }
      after(:all) { DatabaseCleaner.clean }
      before(:all) do
        admin = @users[:admin]
        @group = @groups[:fisica]
        @enrollments_count = Enrollment.count
        @group_enrollments_count = @group.enrollments.count
        url = "/api/v1/enrollments?auth_token=#{admin.authentication_token}"
        data = {:enrollment => {:group_id => @group.id, :user_email => 'non-existing@utp.ac.pa'}}
        post url, data, @headers
        @status = response.status
      end
      it "returns status code 201 (Created)" do
        @status.should eq(201)
      end
      it "creates a new enrollment" do
        Enrollment.count.should be > @enrollments_count
      end
      it "assigns the user to the correct group" do
        @group.enrollments.count.should be > @group_enrollments_count
      end
    end
    describe "when non-existing user_id is sent" do
      before(:all) do
        admin = @users[:admin]
        @group = @groups[:fisica]
        @enrollments_count = Enrollment.count
        url = "/api/v1/enrollments?auth_token=#{admin.authentication_token}"
        data = {:enrollment => {:group_id => @group.id, :user_id => 999}}
        post url, data, @headers
        @status = response.status
      end
      it "returns status code 422 (Unprocessable Entity)" do
        @status.should eq(422)
      end
      it "does not create a new enrollment" do
        Enrollment.count.should eq(@enrollments_count)
      end
    end
    describe "when neither user_id nor email are sent" do
      before(:all) do
        admin = @users[:admin]
        @group = @groups[:fisica]
        @enrollments_count = Enrollment.count
        url = "/api/v1/enrollments?auth_token=#{admin.authentication_token}"
        data = {:enrollment => {:group_id => @group.id}}
        post url, data, @headers
        @status = response.status
      end
      it "returns status code 422 (Unprocessable Entity)" do
        @status.should eq(422)
      end
      it "does not create a new enrollment" do
        Enrollment.count.should eq(@enrollments_count)
      end
    end
    describe "when both user_id and email are sent" do
      before(:all) { DatabaseCleaner.start }
      after(:all) { DatabaseCleaner.clean }
      before(:all) do
        admin = @users[:admin]
        @group = @groups[:fisica]
        @user = @users[:fulano]
        @enrollments_count = Enrollment.count
        url = "/api/v1/enrollments?auth_token=#{admin.authentication_token}"
        data = {:enrollment => {:group_id => @group.id, :user_id => @user.id,
          :user_email => @user.email}}
        post url, data, @headers
        @status = response.status
      end
      it "returns status code 201 (Created)" do
        @status.should eq(201)
      end
      it "creates a new enrollment" do
        Enrollment.count.should be > @enrollments_count
      end
      it "assigns the user to the correct group" do
        @group.members.exists?(@user).should be_true
      end
    end
    describe "when both user_id and email are sent but don't match" do
      before(:all) { DatabaseCleaner.start }
      after(:all) { DatabaseCleaner.clean }
      before(:all) do
        admin = @users[:admin]
        @group = @groups[:fisica]
        @user1 = @users[:fulano]
        @user2 = @users[:mengano]
        @enrollments_count = Enrollment.count
        url = "/api/v1/enrollments?auth_token=#{admin.authentication_token}"
        data = {:enrollment => {:group_id => @group.id, :user_id => @user1.id,
          :user_email => @user2.email}}
        post url, data, @headers
        @status = response.status
      end
      it "returns status code 201 (Created)" do
        @status.should eq(201)
      end
      it "creates a new enrollment" do
        Enrollment.count.should be > @enrollments_count
      end
      it "user id takes precedence over user email" do
        @group.members.exists?(@user1).should be_true
        @group.members.exists?(@user2).should be_false
      end
    end
    describe "when the group doesn't exist" do
      before(:all) do
        admin = @users[:admin]
        @user = @users[:fulano]
        @enrollments_count = Enrollment.count
        url = "/api/v1/enrollments?auth_token=#{admin.authentication_token}"
        data = {:enrollment => {:group_id => 999, :user_id => @user.id}}
        post url, data, @headers
        @status = response.status
      end
      it "returns status code 422 (Unprocessable Entity)" do
        @status.should eq(422)
      end
      it "does not create a new enrollment" do
        Enrollment.count.should eq(@enrollments_count)
      end
    end
    describe "when request format is not set to JSON" do
      before(:all) do
        headers = @headers.clone
        headers['HTTP_ACCEPT'] = 'text/html'
        admin = @users[:admin]
        @group = @groups[:fisica]
        @user = @users[:fulano]
        @enrollments_count = Enrollment.count
        url = "/api/v1/enrollments?auth_token=#{admin.authentication_token}"
        data = {:enrollment => {:group_id => @group.id, :user_id => @user.id}}
        post url, data, headers
        @status = response.status
      end
      it "returns status code 406 (Not Acceptable)" do
        @status.should eq(406)
      end
      it "does not create a new enrollment" do
        Enrollment.count.should eq(@enrollments_count)
      end
    end
    describe "when user is not admin" do
      before(:all) do
        admin = @users[:fulano]
        @group = @groups[:fisica]
        @user = @users[:fulano]
        @enrollments_count = Enrollment.count
        url = "/api/v1/enrollments?auth_token=#{admin.authentication_token}"
        data = {:enrollment => {:group_id => @group.id, :user_id => @user.id}}
        post url, data, @headers
        @status = response.status
      end
      it "returns status code 403 (Forbidden)" do
        @status.should eq(403)
      end
      it "does not create a new enrollment" do
        Enrollment.count.should eq(@enrollments_count)
      end
    end
  end

  describe "DELETE /api/v1/enrollments/:id" do
    before(:all) do
      @group = @groups[:fisica]
      @user = @users[:fulano]
      @enrollment = Enrollment.create!(:group => @group, :user => @user)
    end
    describe "on success" do
      before(:all) { DatabaseCleaner.start }
      after(:all) { DatabaseCleaner.clean }
      before(:all) do
        admin = @users[:admin]
        url = "/api/v1/enrollments/#{@enrollment.id}?auth_token=#{admin.authentication_token}"
        delete url, nil, @headers
        @status = response.status
      end
      it "returns status code 200 (OK)" do
        @status.should eq(200)
      end
      it "deletes the enrollment" do
        Enrollment.find_by_id(@enrollment.id).should be_false
      end

    end
    describe "when enrollment does not exist" do
      before(:all) do
        admin = @users[:admin]
        url = "/api/v1/enrollments/999?auth_token=#{admin.authentication_token}"
        delete url, nil, @headers
        @status = response.status
      end
      it "returns status code 404 (Not Found)" do
        @status.should eq(404)
      end
    end
    describe "when user is not admin" do
      before(:all) { DatabaseCleaner.start }
      after(:all) { DatabaseCleaner.clean }
      before(:all) do
        admin = @users[:fulano]
        url = "/api/v1/enrollments/#{@enrollment.id}?auth_token=#{admin.authentication_token}"
        delete url, nil, @headers
        @status = response.status
      end
      it "returns status code 403 (Forbidden)" do
        @status.should eq(403)
      end
      it "does not delete the enrollment" do
        Enrollment.find_by_id(@enrollment.id).should be_true
      end
    end
    describe "when request format is not set to JSON" do
      before(:all) do
        headers = @headers.clone
        headers['HTTP_ACCEPT'] = 'text/html'
        admin = @users[:admin]
        url = "/api/v1/enrollments/#{@enrollment.id}?auth_token=#{admin.authentication_token}"
        delete url, nil, headers
        @status = response.status
      end
      it "returns status code 406 (Not Acceptable)" do
        @status.should eq(406)
      end
      it "does not delete the enrollment" do
        Enrollment.find_by_id(@enrollment.id).should be_true
      end
    end
  end
end