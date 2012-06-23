# == Schema Information
#
# Table name: board_pics
#
#  id                 :integer(4)      not null, primary key
#  image_file_name    :string(255)
#  image_content_type :string(255)
#  image_file_size    :integer(4)
#  image_updated_at   :datetime
#  created_at         :datetime        not null
#  updated_at         :datetime        not null
#  user_id            :integer(4)
#  group_id           :integer(4)
#  class_date         :date
#

class BoardPic < ActiveRecord::Base
  belongs_to :author, :class_name => 'User', :foreign_key => 'user_id'
  belongs_to :group
  has_attached_file :image, :styles => { :thumb => "100x100>" }

  validates :class_date, :presence => true
  validates :image, :attachment_presence => true
end