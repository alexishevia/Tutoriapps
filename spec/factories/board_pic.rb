FactoryGirl.define do
  factory :board_pic do
    image File.open("#{Rails.root}/spec/support/rails.png")
    author :factory => :user
    group
  end
end