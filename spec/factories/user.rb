FactoryGirl.define do
  factory :user do
    name Forgery::Name.full_name
    sequence(:email) { |n| "usuario#{n}@utp.ac.pa" }
    password Forgery::Basic.password
  end
end