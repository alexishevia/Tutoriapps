require 'spec_helper'

describe "Tokens V1 API" do
  before(:all) do
    User.destroy_all
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
    User.destroy_all
  end

  describe "POST /api/v1/tokens" do

    describe "on success" do
      it "returns status code 200" do
        post '/api/v1/tokens', {:email => @users_attrs[:fulano][:email], 
          :password => @users_attrs[:fulano][:password]}, @headers
        response.status.should eq(200)
      end
      it "returns a JSON object with the token" do
        post '/api/v1/tokens', {:email => @users_attrs[:fulano][:email], 
          :password => @users_attrs[:fulano][:password]}, @headers
        data = JSON.parse(response.body)
        data['token'].should eq(@users[:fulano].reload.authentication_token)
      end
    end

    describe "when request format is not set to JSON" do
      it "returns status code 406" do
        post '/api/v1/tokens', {:email => @users_attrs[:fulano][:email], 
          :password => @users_attrs[:fulano][:password]}, nil
        response.status.should eq(406)
      end
    end

    describe "when email or password is not sent" do
      it "returns status code 400" do
        post '/api/v1/tokens', {:email => nil, 
          :password => @users_attrs[:fulano][:password]}, @headers
        response.status.should eq(400)
        post '/api/v1/tokens', {:email => @users_attrs[:fulano][:email], 
          :password => nil}, @headers
        response.status.should eq(400)
      end
    end

    describe "when email and password don't match" do
      it "returns status code 401" do
        post '/api/v1/tokens', {:email => 'wrong@utp.ac.pa', 
          :password => @users_attrs[:fulano][:password]}, @headers
        response.status.should eq(401)
        post '/api/v1/tokens', {:email => @users_attrs[:fulano][:email], 
          :password => 'wrong'}, @headers
        response.status.should eq(401)
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
      it "returns status code 200" do
        delete "/api/v1/tokens/#{@old_token}"
        response.status.should eq(200)
      end
      it "resets access token" do
        delete "/api/v1/tokens/#{@old_token}"
        @old_token.should_not eq(@user.reload.authentication_token)
      end
    end

    describe "when token is not valid" do
      it "returns status code 404" do
        delete "/api/v1/tokens/wrong"
        response.status.should eq(404)
      end
    end
  end
end