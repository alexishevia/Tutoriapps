# == Schema Information
#
# Table name: groups
#
#  id         :integer(4)      not null, primary key
#  name       :string(255)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

class Group < ActiveRecord::Base
  attr_accessible :name
  has_many :posts
  has_many :enrollments
  has_many :members, :through => :enrollments, :source => :user

  validates :name, :presence => true

  def to_param
    "#{id}-#{name.parameterize}"
  end

  def unregistered_members
    enrollments.where('user_id IS NULL').collect do |enrollment|
      User.new(:email => enrollment.user_email)
    end
  end

end
