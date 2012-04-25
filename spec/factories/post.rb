FactoryGirl.define do
  factory :post do
    text Forgery::LoremIpsum.sentence
    user
    group
  end
end