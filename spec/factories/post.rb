FactoryGirl.define do
  factory :post do
    text Forgery::LoremIpsum.sentence
    author :factory => :user
    group
  end
end