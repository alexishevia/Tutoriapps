FactoryGirl.define do
  factory :book do
    sequence :title do |n|
      Forgery::LoremIpsum.words(6, :random => n)
    end
    author Forgery::Name.full_name
    publisher Forgery::Name.full_name
    sequence :additional_info do |n|
      Forgery::LoremIpsum.sentence(:random => n)
    end
    sequence :contact_info do |n|
      Forgery::LoremIpsum.sentence(:random => n)
    end
    owner :factory => :user
    group
  end
end