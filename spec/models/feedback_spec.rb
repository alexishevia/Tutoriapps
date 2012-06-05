# == Schema Information
#
# Table name: feedbacks
#
#  id         :integer(4)      not null, primary key
#  text       :text
#  created_at :datetime        not null
#  updated_at :datetime        not null
#  user_id    :integer(4)
#

require 'spec_helper'

describe Feedback do
  it "sends an email when created" do
    user = FactoryGirl.create(:user)
    lambda {
      FactoryGirl.create(:feedback, :user => user) 
    }.should change(ActionMailer::Base.deliveries,:size).by(1)
  end
end
