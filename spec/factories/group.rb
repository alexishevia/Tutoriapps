FactoryGirl.define do
  factory :group do
    sequence(:name) { |n| "Grupo#{n}" }
  end
end