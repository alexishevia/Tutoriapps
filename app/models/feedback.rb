# == Schema Information
#
# Table name: feedbacks
#
#  id         :integer(4)      not null, primary key
#  text       :text
#  created_at :datetime        not null
#  updated_at :datetime        not null
#  user_id    :integer(4)
#

class Feedback < ActiveRecord::Base
  belongs_to :user
  validates :text, :user, :presence => true
  after_create :send_email

  private
    def send_email
      FeedbackMailer.new_feedback(self).deliver
    end
end
