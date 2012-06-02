#coding: utf-8
require 'spec_helper'

describe "Feedbacks V1 API" do
  before(:all) do 
    @users = {
      :fulano => FactoryGirl.create(:user),
      :mengano => FactoryGirl.create(:user)
    }
    @users.each do |key, user| 
      user.confirmed_at = Time.now
      user.admin = (key == :admin)
      user.save!
      user.reset_authentication_token!
      user.reload
    end

    @headers = {'HTTP_ACCEPT' => 'application/json'}  
  end

  describe "POST /api/v1/feedbacks" do
    describe "on success" do
      before(:all) { DatabaseCleaner.start }
      after(:all) { DatabaseCleaner.clean }
      before(:all) do
        user = @users[:fulano]
        url = "/api/v1/feedbacks?auth_token=#{user.authentication_token}"
        @data = {:feedback => FactoryGirl.attributes_for(:feedback)}
        post url, @data, @headers
        @status = response.status
      end
      it "returns status code 201 (Created)" do
        @status.should eq(201)
      end
      it "creates a new feedback" do
        Feedback.count.should eq(1)
      end
    end
    describe "when request format is not set to JSON" do
      before(:all) do
        headers = @headers.clone
        headers['HTTP_ACCEPT'] = 'text/html'
        user = @users[:fulano]
        url = "/api/v1/feedbacks?auth_token=#{user.authentication_token}"
        @data = {:group => FactoryGirl.attributes_for(:feedback)}
        post url, @data, headers
        @status = response.status
      end
      it "returns status code 406 (Not Acceptable)" do
        @status.should eq(406)
      end
      it "does not create a new feedback" do
        Feedback.count.should eq(0)
      end
    end
    describe "when auth token is not valid or was not sent" do
      before(:all) do
        @data = {:group => FactoryGirl.attributes_for(:feedback)}
        url = "/api/v1/feedbacks"
        post url, @data, @headers
        @status1 = response.status
        url = "/api/v1/feedbacks?auth_token=invalid"
        post url, @data, @headers
        @status2 = response.status
      end
      it "returns status code 401 (Unauthorized)" do
        @status1.should eq(401)
        @status2.should eq(401)
      end
    end
  end

end