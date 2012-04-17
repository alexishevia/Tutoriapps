require 'spec_helper'

describe User do
  it "solo acepta correos de la UTP" do
    attrs = FactoryGirl.attributes_for(:user)
    User.new(attrs).valid?.should be_true
    User.new(attrs.merge(:email => 'user@utp.ac.pa')).valid?.should be_true
    User.new(attrs.merge(:email => 'user@gmail.com')).valid?.should be_false
    User.new(attrs.merge(:email => 'user@hotmail.com')).valid?.should be_false
  end
end