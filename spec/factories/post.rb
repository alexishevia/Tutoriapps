FactoryGirl.define do
  factory :post do
    text Forgery::LoremIpsum.sentence
  end
end