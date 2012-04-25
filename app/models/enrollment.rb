# == Schema Information
#
# Table name: enrollments
#
#  id         :integer(4)      not null, primary key
#  user_email :string(255)
#  group_id   :integer(4)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

class Enrollment < ActiveRecord::Base
  belongs_to :group
  belongs_to :user, :foreign_key => :user_email
end
