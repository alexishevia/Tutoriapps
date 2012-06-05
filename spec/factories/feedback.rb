FactoryGirl.define do
  factory :feedback do
    text Forgery::LoremIpsum.sentence
    user
  end
end