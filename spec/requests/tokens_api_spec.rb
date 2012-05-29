require 'spec_helper'

describe "Tokens V1 API" do
  before(:all) do
    @users_attrs = {
      :fulano => FactoryGirl.attributes_for(:user, :email => 'fulano@utp.ac.pa'),
      :mengano => FactoryGirl.attributes_for(:user, :email => 'mengano@utp.ac.pa')
    }
    @users = {}
    @users_attrs.each do |key, value|
      @users[key] = User.create!(value)
    end
    @headers = {'HTTP_ACCEPT' => 'application/json'}
  end

  after(:all) do
    DatabaseCleaner.clean
  end

  describe "POST /api/v1/tokens" do

    describe "on success" do
      before(:all) do
        post '/api/v1/tokens', {:email => @users_attrs[:fulano][:email], 
          :password => @users_attrs[:fulano][:password]}, @headers
        @status = response.status
        @data = JSON.parse(response.body)
      end
      it "returns status code 200 (OK)" do
        @status.should eq(200)
      end
      it "returns a JSON object with the token" do
        @data['token'].should eq(@users[:fulano].reload.authentication_token)
      end
    end

    describe "when request format is not set to JSON" do
      before(:all) do
        headers = @headers.clone
        headers['HTTP_ACCEPT'] = 'text/html'
        post '/api/v1/tokens', {:email => @users_attrs[:fulano][:email], 
          :password => @users_attrs[:fulano][:password]}, headers
        @status = response.status
        @data = JSON.parse(response.body)
      end
      it "returns status code 406 (Not Acceptable)" do
        @status.should eq(406)
      end
      it "does not return the token" do
        @data['token'].should be_false
      end
    end

    describe "when email is not sent" do
      before(:all) do
        post '/api/v1/tokens', {:email => nil, 
          :password => @users_attrs[:fulano][:password]}, @headers
        @status = response.status
        @data = JSON.parse(response.body)
      end
      it "returns status code 400 (Bad Request)" do
        @status.should eq(400)
      end
      it "does not return the token" do
        @data['token'].should be_false
      end
    end

    describe "when password is not sent" do
      before(:all) do
        post '/api/v1/tokens', {:email => @users_attrs[:fulano][:email], 
          :password => nil}, @headers
        @status = response.status
        @data = JSON.parse(response.body)
      end
      it "returns status code 400 (Bad Request)" do
        @status.should eq(400)
      end
      it "does not return the token" do
        @data['token'].should be_false
      end
    end

    describe "when email and password don't match" do
      before(:all) do
        post '/api/v1/tokens', {:email => 'wrong@utp.ac.pa', 
          :password => @users_attrs[:fulano][:password]}, @headers
        @status1 = response.status
        @data1 = JSON.parse(response.body)
        post '/api/v1/tokens', {:email => @users_attrs[:fulano][:email], 
          :password => 'wrong'}, @headers
        @status2 = response.status
        @data2 = JSON.parse(response.body)
      end
      it "returns status code 401 (Unauthorized)" do        
        @status1.should eq(401)
        @status2.should eq(401)
      end
      it "does not return the token" do
        @data1['token'].should be_false
        @data2['token'].should be_false
      end
    end
  end

  describe "DELETE /api/v1/tokens/:token" do
    before(:each) do
      @user = @users[:fulano]
      @user.reset_authentication_token!
      @old_token = @user.reload.authentication_token
    end

    describe "on success" do
      before(:each) do
        delete "/api/v1/tokens/#{@old_token}", nil, @headers
        @status = response.status
      end
      it "returns status code 200 (OK)" do        
        @status.should eq(200)
      end
      it "resets access token" do
        @old_token.should_not eq(@user.reload.authentication_token)
      end
    end

    describe "when request format is not set to JSON" do
      before(:each) do
        headers = @headers.clone
        headers['HTTP_ACCEPT'] = 'text/html'
        delete "/api/v1/tokens/#{@old_token}", nil, headers
        @status = response.status
      end
      it "returns status code 406 (Not Acceptable)" do
        @status.should eq(406)
      end
      it "access token is not changed" do
        @old_token.should eq(@user.reload.authentication_token)
      end
    end

    describe "when token is not valid" do
      before(:each) do
        delete "/api/v1/tokens/wrong", nil, @headers
        @status = response.status
      end
      it "returns status code 404 (Not Found)" do        
        @status.should eq(404)
      end
      it "access token is not changed" do
        @old_token.should eq(@user.reload.authentication_token)
      end
    end
  end
end