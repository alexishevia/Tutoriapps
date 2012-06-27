FactoryGirl.define do
  factory :board_pic do
    image File.open("#{Rails.root}/spec/support/rails.png")
    author :factory => :user
    class_date {Date.today - rand(0..100).days}
    group
  end
end