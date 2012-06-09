FactoryGirl.define do
  factory :reply do
    text Forgery::LoremIpsum.sentence
    author :factory => :user
    post
  end
end