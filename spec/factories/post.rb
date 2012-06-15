FactoryGirl.define do
  factory :post do
    sequence :text do |n|
      Forgery::LoremIpsum.sentence(:random => n)
    end
    author :factory => :user
    group
  end
end