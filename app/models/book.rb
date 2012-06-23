# == Schema Information
#
# Table name: books
#
#  id              :integer(4)      not null, primary key
#  user_id         :integer(4)
#  group_id        :integer(4)
#  title           :string(255)
#  author          :string(255)
#  publisher       :string(255)
#  available       :boolean(1)      default(TRUE), not null
#  additional_info :text
#  contact_info    :text
#  created_at      :datetime        not null
#  updated_at      :datetime        not null
#

class Book < ActiveRecord::Base
  belongs_to :owner, :class_name => 'User', :foreign_key => 'user_id'
  belongs_to :group
  has_many :replies, :as => :post

  validates :title, :author, :publisher, :presence => true
end
