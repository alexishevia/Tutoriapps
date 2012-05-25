require 'spec_helper'

describe "Tokens V1 API" do
  before(:all) do
    User.destroy_all
    @users_attrs = {
      'fulano' => FactoryGirl.attributes_for(:user, :email => 'fulano@utp.ac.pa'),
      'mengano' => FactoryGirl.attributes_for(:user, :email => 'mengano@utp.ac.pa')
    }
    @users = {}
    @users_attrs.each do |key, value|
      @users[key] = User.create!(value)
    end
  end

  describe "when correct email and password is sent" do
    it "returns a JSON object with the token" do
      post '/api/v1/tokens.json', {:email => @users_attrs['fulano']['email'], 
        :password => @users_attrs['fulano']['password']}
      response.status.should eq(200)
      data = JSON.parse(last_response.body)
      data['token'].should eq(@users['fulano'].authentication_token)
    end
  end
end