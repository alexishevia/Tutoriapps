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
#

class BoardPic < ActiveRecord::Base
  has_attached_file :image
end
