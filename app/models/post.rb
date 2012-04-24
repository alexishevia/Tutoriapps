# == Schema Information
#
# Table name: posts
#
#  id         :integer(4)      not null, primary key
#  user_id    :integer(4)
#  group_id   :integer(4)
#  text       :string(255)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

class Post < ActiveRecord::Base
  belongs_to :user
  belongs_to :group

  validates :user, :group, :text, :presence => true
end
