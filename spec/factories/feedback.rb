FactoryGirl.define do
  factory :feedback do
    text Forgery::LoremIpsum.sentence
  end
end