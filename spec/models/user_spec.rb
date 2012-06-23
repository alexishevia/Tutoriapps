# == Schema Information
#
# Table name: users
#
#  id                     :integer(4)      not null, primary key
#  email                  :string(255)     default(""), not null
#  encrypted_password     :string(255)     default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer(4)      default(0)
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  confirmation_token     :string(255)
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string(255)
#  authentication_token   :string(255)
#  created_at             :datetime        not null
#  updated_at             :datetime        not null
#  name                   :string(255)
#  admin                  :boolean(1)      default(FALSE), not null
#

require 'spec_helper'

describe User do
  it "only accepts emails from UTP" do
    attrs = FactoryGirl.attributes_for(:user)
    User.new(attrs).valid?.should be_true
    User.new(attrs.merge(:email => 'user@utp.ac.pa')).valid?.should be_true
    User.new(attrs.merge(:email => 'user@gmail.com')).valid?.should be_false
    User.new(attrs.merge(:email => 'user@hotmail.com')).valid?.should be_false
  end
end
