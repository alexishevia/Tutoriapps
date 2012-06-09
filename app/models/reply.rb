# == Schema Information
#
# Table name: replies
#
#  id         :integer(4)      not null, primary key
#  post_id    :integer(4)
#  user_id    :integer(4)
#  text       :text
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

class Reply < ActiveRecord::Base
  belongs_to :author, :class_name => 'User', :foreign_key => 'user_id'
  belongs_to :post
  validates :post, :author, :text, :presence => true
end
