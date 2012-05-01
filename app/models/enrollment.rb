# == Schema Information
#
# Table name: enrollments
#
#  id         :integer(4)      not null, primary key
#  user_email :string(255)
#  group_id   :integer(4)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#  user_id    :integer(4)
#

class Enrollment < ActiveRecord::Base
  belongs_to :group
  belongs_to :user

  before_validation :search_user_email

  private
    def search_user_email
      return unless user_email
      user = User.find_by_email(user_email)
      if user
        self.user_email = nil
        self.user = user
      end
    end
end
