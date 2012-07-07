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
  has_many :posts, :dependent => :destroy
  has_many :board_pics, :dependent => :destroy
  has_many :books, :dependent => :destroy
  has_many :enrollments, :dependent => :destroy
  has_many :members, :through => :enrollments, :source => :user

  validates :name, :presence => true

  def unregistered_members
    enrollments.where('user_id IS NULL').collect do |enrollment|
      User.new(:email => enrollment.user_email)
    end
  end

  def content
    posts + board_pics + books
  end

end
