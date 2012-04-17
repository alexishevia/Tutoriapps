FactoryGirl.define do
  factory :user do
    sequence(:name) { |n| "Usuario#{n}" }
    sequence(:email) { |n| "usuario#{n}@utp.ac.pa" }
    password "secreto"
    password_confirmation { |u| u.password }
  end
end