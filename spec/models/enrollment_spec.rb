require 'spec_helper'

describe Enrollment do
  it "searches for existing user_email and assigns correct user" do
    user = FactoryGirl.create(:user)
    Enrollment.where('user_id = ?', user.id).count.should eq(0)
    enrollment = FactoryGirl.create(:enrollment, :user => nil, 
      :user_email => user.email)
    Enrollment.where('user_id = ?', user.id).count.should eq(1)
  end
end