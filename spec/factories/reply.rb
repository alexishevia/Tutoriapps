FactoryGirl.define do
  factory :reply do
    sequence :text do |n|
      Forgery::LoremIpsum.sentence(:random => n)
    end
    author :factory => :user
    post
  end
end