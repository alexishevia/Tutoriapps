FactoryGirl.define do
  factory :user do
    sequence(:name) { |n| "User#{n}" }
    sequence(:email) { |n| "user#{n}@utp.ac.pa" }
    password "foobar"
    password_confirmation { |u| u.password }
  end
end